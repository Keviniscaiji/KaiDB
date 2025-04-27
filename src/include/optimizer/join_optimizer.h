#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <map>
#include <set>
#include <string>
#include <tuple>
#include <vector>

#include "operators/seq_scan.h"
#include "table_stats.h"

using buzzdb::operators::PredicateType;
using buzzdb::table_stats::TableStats;

namespace buzzdb {
namespace optimizer {

class LogicalJoinNode {
   public:
    std::string left_table;
    std::string right_table;
    uint64_t left_field;
    uint64_t right_field;
    PredicateType op;

    bool operator<(const LogicalJoinNode& jn) const {
        return std::tie(left_table, right_table, left_field, right_field, op) <
               std::tie(jn.left_table, jn.right_table, jn.left_field, jn.right_field, jn.op);
    }

    bool operator==(const LogicalJoinNode& jn) const {
        return std::tie(left_table, right_table, left_field, right_field, op) ==
               std::tie(jn.left_table, jn.right_table, jn.left_field, jn.right_field, jn.op);
    }
    LogicalJoinNode() = default;
    LogicalJoinNode(std::string left_table, std::string right_table, uint64_t left_field,
                    uint64_t right_field, PredicateType op)
        : left_table(left_table),
          right_table(right_table),
          left_field(left_field),
          right_field(right_field),
          op(op) {}
    ~LogicalJoinNode() = default;
    LogicalJoinNode swap_inner_outer() {
        return LogicalJoinNode(right_table, left_table, right_field, left_field, op);
    }
};

struct CostCard {
    double cost;
    int card;
    std::vector<LogicalJoinNode> plan;
};

class PlanCache {
   public:
    static std::map<std::set<LogicalJoinNode>, std::vector<LogicalJoinNode>> best_orders;
    static std::map<std::set<LogicalJoinNode>, double> best_costs;
    static std::map<std::set<LogicalJoinNode>, int> best_cardinalities;

    void add_plan(const std::set<LogicalJoinNode>& s, double cost, int card,
                  const std::vector<LogicalJoinNode>& order) {
        best_orders[s] = order;
        best_costs[s] = cost;
        best_cardinalities[s] = card;
    }
    std::vector<LogicalJoinNode> get_order(const std::set<LogicalJoinNode>& s) {
        if (best_orders.find(s) != best_orders.end())
            return best_orders[s];
        else
            return std::vector<LogicalJoinNode>();
    }
    double get_cost(const std::set<LogicalJoinNode>& s) { return best_costs[s]; }
    int get_card(const std::set<LogicalJoinNode>& s) { return best_cardinalities[s]; }
};

class JoinOptimizer {
   public:
    JoinOptimizer(std::vector<LogicalJoinNode> joins);
    JoinOptimizer() = default;
    ~JoinOptimizer() = default;
    double estimate_join_cost(LogicalJoinNode j, uint64_t card1, uint64_t card2, double cost1,
                              double cost2, std::map<std::string, TableStats>& stats);
    int estimate_join_cardinality(LogicalJoinNode j, uint64_t card1, uint64_t card2, bool t1pkey,
                                  bool t2pkey, std::map<std::string, TableStats>& stats);
    std::vector<LogicalJoinNode> order_joins(
        const std::map<std::string, TableStats>& stats,
        const std::map<std::string, double>& filter_selectivities);

   private:
    std::vector<LogicalJoinNode> _joins;
    // 修改点：PlanCache 参数通过引用传递
    bool compute_cost_and_card_of_subplan(std::map<std::string, TableStats> stats,
                                          std::map<std::string, double> filter_selectivities,
                                          LogicalJoinNode join_to_remove,
                                          std::set<LogicalJoinNode> join_set,
                                          double best_cost_so_far, PlanCache& pc, CostCard& cc);
    bool has_Pkey(std::vector<LogicalJoinNode> joinlist);
    bool does_join(std::vector<LogicalJoinNode> joinlist, std::string table_name);
    std::set<std::set<LogicalJoinNode>> enumerate_subsets(std::vector<LogicalJoinNode> v, int size);
};

}  // namespace optimizer
}  // namespace buzzdb
