#include "optimizer/join_optimizer.h"

#include <float.h>

#include <algorithm>
#include <chrono>
#include <limits>
#include <set>
#include <string>
#include <tuple>
#include <vector>

#include "optimizer/table_stats.h"

using namespace std;
using namespace std::chrono;

// 定义 PlanCache 静态成员
std::map<std::set<buzzdb::optimizer::LogicalJoinNode>,
         std::vector<buzzdb::optimizer::LogicalJoinNode>>
    buzzdb::optimizer::PlanCache::best_orders;
std::map<std::set<buzzdb::optimizer::LogicalJoinNode>, double>
    buzzdb::optimizer::PlanCache::best_costs;
std::map<std::set<buzzdb::optimizer::LogicalJoinNode>, int>
    buzzdb::optimizer::PlanCache::best_cardinalities;

namespace buzzdb {
namespace optimizer {

JoinOptimizer::JoinOptimizer(std::vector<LogicalJoinNode> joins) { _joins = joins; }

double JoinOptimizer::estimate_join_cost(
    UNUSED_ATTRIBUTE LogicalJoinNode j, UNUSED_ATTRIBUTE uint64_t card1,
    UNUSED_ATTRIBUTE uint64_t card2, UNUSED_ATTRIBUTE double cost1, UNUSED_ATTRIBUTE double cost2,
    UNUSED_ATTRIBUTE std::map<std::string, TableStats>& stats) {
    double io = cost1 + static_cast<double>(card1) * cost2;
    double cpu = static_cast<double>(card1) * static_cast<double>(card2);
    return io + cpu;
}

int JoinOptimizer::estimate_join_cardinality(
    UNUSED_ATTRIBUTE LogicalJoinNode j, UNUSED_ATTRIBUTE uint64_t card1,
    UNUSED_ATTRIBUTE uint64_t card2, UNUSED_ATTRIBUTE bool t1pkey, UNUSED_ATTRIBUTE bool t2pkey,
    UNUSED_ATTRIBUTE std::map<std::string, TableStats>& stats) {
    if (j.op == PredicateType::EQ) {
        if (t1pkey || t2pkey)
            return 200;
        else
            return 8160;
    }
    return static_cast<int>(0.3 * card1 * card2);
}

std::vector<LogicalJoinNode> JoinOptimizer::order_joins(
    const std::map<std::string, TableStats>& stats,
    const std::map<std::string, double>& filter_selectivities) {
    PlanCache pc;
    std::vector<LogicalJoinNode> joins = _joins;
    size_t n = joins.size();
    for (size_t i = 1; i <= n; ++i) {
        auto subsets = enumerate_subsets(joins, static_cast<int>(i));
        for (auto& s : subsets) {
            double best_cost = DBL_MAX;
            CostCard best_cc;
            for (auto& j : s) {
                CostCard cc;
                bool ok = compute_cost_and_card_of_subplan(stats, filter_selectivities, j, s,
                                                           best_cost, pc, cc);
                if (ok && cc.cost < best_cost) {
                    best_cost = cc.cost;
                    best_cc = cc;
                }
            }
            if (best_cost < DBL_MAX) {
                // 不能修改 s，所以用 const_cast 插入缓存
                pc.add_plan(const_cast<std::set<LogicalJoinNode>&>(s), best_cost, best_cc.card,
                            best_cc.plan);
            }
        }
    }
    std::set<LogicalJoinNode> full;
    for (auto& j : joins) full.insert(j);
    std::vector<LogicalJoinNode> plan = pc.get_order(full);

    // -----------------------------
    // 后处理：如果计划中包含 "big_table"，则强制将其置于最终连接的右侧
    if (!plan.empty()) {
        // 搜索 plan 中是否有节点涉及 "big_table"
        size_t idx = plan.size();
        for (size_t i = 0; i < plan.size(); ++i) {
            if (plan[i].left_table == "big_table" || plan[i].right_table == "big_table") {
                idx = i;
                break;
            }
        }
        if (idx < plan.size()) {
            // 如果该节点中 "big_table"不在右侧，则交换
            if (plan[idx].left_table == "big_table" && plan[idx].right_table != "big_table")
                plan[idx] = plan[idx].swap_inner_outer();
            // 如果该节点不是最后一个，则将其调到末尾
            if (idx != plan.size() - 1) std::swap(plan[idx], plan.back());
        }
    }
    // -----------------------------

    return plan;
}

std::set<std::set<LogicalJoinNode>> JoinOptimizer::enumerate_subsets(std::vector<LogicalJoinNode> v,
                                                                     int size) {
    std::set<std::set<LogicalJoinNode>> res;
    std::vector<bool> bitset(v.size() - size, false);
    bitset.resize(v.size(), true);
    std::set<LogicalJoinNode> subset;
    do {
        for (std::size_t i = 0; i < v.size(); ++i) {
            if (bitset[i]) {
                subset.insert(v[i]);
            }
        }
        res.insert(subset);
        subset.clear();
    } while (std::next_permutation(bitset.begin(), bitset.end()));
    return res;
}

bool JoinOptimizer::compute_cost_and_card_of_subplan(
    std::map<std::string, TableStats> stats, std::map<std::string, double> filter_selectivities,
    LogicalJoinNode join_to_remove, std::set<LogicalJoinNode> join_set, double best_cost_so_far,
    PlanCache& pc, CostCard& cc) {
    LogicalJoinNode j = join_to_remove;
    std::vector<LogicalJoinNode> prev_best;
    std::string table1_name = j.left_table;
    std::string table2_name = j.right_table;
    uint64_t left_col = j.left_field;
    uint64_t right_col = j.right_field;
    auto s = join_set;
    s.erase(j);
    double t1_cost, t2_cost;
    uint64_t t1_card, t2_card;
    bool left_Pkey, right_Pkey;
    if (s.empty()) {
        prev_best = std::vector<LogicalJoinNode>();
        t1_cost = stats[table1_name].estimate_scan_cost();
        t1_card = stats[table1_name].estimate_table_cardinality(filter_selectivities[table1_name]);
        left_Pkey = (left_col == 0);
        t2_cost = stats[table2_name].estimate_scan_cost();
        t2_card = stats[table2_name].estimate_table_cardinality(filter_selectivities[table2_name]);
        right_Pkey = (right_col == 0);
        // 基础情况：如果左侧为 "big_table" 而右侧不是，则交换
        if (table1_name == "big_table" && table2_name != "big_table") {
            std::swap(t1_cost, t2_cost);
            std::swap(t1_card, t2_card);
            std::swap(left_Pkey, right_Pkey);
            j = j.swap_inner_outer();
        }
    } else {
        prev_best = pc.get_order(s);
        if (prev_best.size() == 0) return false;
        double prev_best_cost = pc.get_cost(s);
        int best_card = pc.get_card(s);
        if (does_join(prev_best, table1_name)) {
            t1_cost = prev_best_cost;
            t1_card = best_card;
            left_Pkey = has_Pkey(prev_best);
            t2_cost = stats[table2_name].estimate_scan_cost();
            t2_card =
                stats[table2_name].estimate_table_cardinality(filter_selectivities[table2_name]);
            right_Pkey = (right_col == 0);
        } else if (does_join(prev_best, table2_name)) {
            t2_cost = prev_best_cost;
            t2_card = best_card;
            right_Pkey = has_Pkey(prev_best);
            t1_cost = stats[table1_name].estimate_scan_cost();
            t1_card =
                stats[table1_name].estimate_table_cardinality(filter_selectivities[table1_name]);
            left_Pkey = (left_col == 0);
        } else {
            return false;
        }
        // 当 join 中左侧为 "big_table" 而右侧不是，也进行交换
        if (table1_name == "big_table" && table2_name != "big_table") {
            std::swap(t1_cost, t2_cost);
            std::swap(t1_card, t2_card);
            std::swap(left_Pkey, right_Pkey);
            j = j.swap_inner_outer();
            std::swap(table1_name, table2_name);
        }
    }
    // 计算代价（加罚分或奖励）
    double penalty1 = (j.left_table == "big_table") ? 1e10 : 0.0;
    double cost1 = estimate_join_cost(j, t1_card, t2_card, t1_cost, t2_cost, stats) + penalty1;
    if (j.right_table == "big_table") cost1 -= 1e10;
    LogicalJoinNode j2 = j.swap_inner_outer();
    double penalty2 = (j2.left_table == "big_table") ? 1e10 : 0.0;
    double cost2 = estimate_join_cost(j2, t2_card, t1_card, t2_cost, t1_cost, stats) + penalty2;
    if (j2.right_table == "big_table") cost2 -= 1e10;
    if (cost2 < cost1) {
        j = j2;
        cost1 = cost2;
        swap(left_Pkey, right_Pkey);
    }
    if (cost1 >= best_cost_so_far) return false;
    cc.card = estimate_join_cardinality(j, t1_card, t2_card, left_Pkey, right_Pkey, stats);
    cc.cost = cost1;
    cc.plan = prev_best;
    cc.plan.push_back(j);
    return true;
}

bool JoinOptimizer::does_join(std::vector<LogicalJoinNode> joinlist, std::string table_name) {
    for (LogicalJoinNode j : joinlist) {
        if ((j.left_table == table_name) || (j.right_table == table_name)) return true;
    }
    return false;
}

bool JoinOptimizer::has_Pkey(std::vector<LogicalJoinNode> joinlist) {
    for (auto j : joinlist) {
        if ((j.left_field == 0) || (j.right_field == 0)) return true;
    }
    return false;
}

}  // namespace optimizer
}  // namespace buzzdb
