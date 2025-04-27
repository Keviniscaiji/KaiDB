#include "optimizer/table_stats.h"

#include <algorithm>
#include <cassert>
#include <cmath>

namespace buzzdb {
namespace table_stats {

//================== IntHistogram 的实现 ==================

// 构造函数
IntHistogram::IntHistogram(int64_t buckets, int64_t min_val, int64_t max_val)
    : buckets(buckets), min_val(min_val), max_val(max_val), total(0) {
    assert(buckets > 0);
    assert(max_val >= min_val);
    bucket_width = (max_val - min_val + 1) / static_cast<double>(buckets);
    counts.resize(buckets, 0);
}

// 拷贝构造函数
IntHistogram::IntHistogram(const IntHistogram& other)
    : buckets(other.buckets),
      min_val(other.min_val),
      max_val(other.max_val),
      bucket_width(other.bucket_width),
      total(other.total),
      counts(other.counts) {}

// 添加数值
void IntHistogram::add_value(int64_t val) {
    int bucket_index;
    if (val < min_val) {
        bucket_index = 0;
    } else if (val > max_val) {
        bucket_index = buckets - 1;
    } else {
        bucket_index = static_cast<int>((val - min_val) / bucket_width);
    }
    if (bucket_index < 0) bucket_index = 0;
    if (bucket_index >= buckets) bucket_index = buckets - 1;

    counts[bucket_index]++;
    total++;
}

double IntHistogram::estimate_selectivity(PredicateType op, int64_t v) {
    if (total == 0) return 0.0;
    // 如果桶数正好等于 [min_val, max_val] 中的整数个数，则采用离散累加方式
    if ((max_val - min_val + 1) == buckets) {
        if (op == PredicateType::EQ) {
            if (v < min_val || v > max_val) return 0.0;
            int index = v - min_val;
            return counts[index] / static_cast<double>(total);
        }
        if (op == PredicateType::NE) {
            if (v < min_val || v > max_val) return 1.0;
            int index = v - min_val;
            return 1.0 - counts[index] / static_cast<double>(total);
        }
        if (op == PredicateType::LT) {
            if (v <= min_val) return 0.0;
            if (v > max_val) return 1.0;
            int index = v - min_val;  // v在对应的桶中
            double cum = 0;
            for (int i = 0; i < index; i++) {
                cum += counts[i];
            }
            return cum / total;
        }
        if (op == PredicateType::GT) {
            if (v >= max_val) return 0.0;
            if (v < min_val) return 1.0;
            int index = v - min_val;
            double cum = 0;
            for (int i = index + 1; i < buckets; i++) {
                cum += counts[i];
            }
            return cum / total;
        }
        if (op == PredicateType::LE) {
            if (v < min_val) return 0.0;
            if (v >= max_val) return 1.0;
            int index = v - min_val;
            double cum = 0;
            for (int i = 0; i <= index; i++) {
                cum += counts[i];
            }
            return cum / total;
        }
        if (op == PredicateType::GE) {
            if (v <= min_val) return 1.0;
            if (v > max_val) return 0.0;
            int index = v - min_val;
            double cum = 0;
            for (int i = index; i < buckets; i++) {
                cum += counts[i];
            }
            return cum / total;
        }
    }
    // 如果桶数与离散整数数不一致，使用原有的近似计算
    if (op == PredicateType::EQ) {
        if (v < min_val || v > max_val) return 0.0;
    }
    if (op == PredicateType::NE) {
        if (v < min_val || v > max_val) return 1.0;
    }
    if (op == PredicateType::GT && v < min_val) return 1.0;
    if (op == PredicateType::LT && v > max_val) return 1.0;
    if (op == PredicateType::GE) return 1.0 - estimate_selectivity(PredicateType::LT, v);
    if (op == PredicateType::LE) return 1.0 - estimate_selectivity(PredicateType::GT, v);

    int bucket_index;
    if (v < min_val)
        bucket_index = 0;
    else if (v > max_val)
        bucket_index = buckets - 1;
    else
        bucket_index = static_cast<int>((v - min_val) / bucket_width);

    double count_in_bucket = counts[bucket_index];
    if (op == PredicateType::EQ) {
        double eq_sel = (count_in_bucket / bucket_width) / total;
        return eq_sel;
    }
    if (op == PredicateType::NE) {
        double eq_sel = (count_in_bucket / bucket_width) / total;
        return 1.0 - eq_sel;
    }
    if (op == PredicateType::GT) {
        if (v >= max_val) return 0.0;
        double bucket_right = min_val + (bucket_index + 1) * bucket_width;
        double fraction = (bucket_right - v) / bucket_width;
        double total_gt = fraction * count_in_bucket;
        for (int i = bucket_index + 1; i < buckets; i++) {
            total_gt += counts[i];
        }
        return total_gt / total;
    }
    if (op == PredicateType::LT) {
        if (v <= min_val) return 0.0;
        double bucket_left = min_val + bucket_index * bucket_width;
        double fraction = (v - bucket_left) / bucket_width;
        double total_lt = fraction * count_in_bucket;
        for (int i = 0; i < bucket_index; i++) {
            total_lt += counts[i];
        }
        return total_lt / total;
    }
    return 1.0;
}

//================== TableStats 的实现 ==================

TableStats::TableStats(int64_t table_id, int64_t io_cost_per_page, uint64_t num_pages,
                       uint64_t num_fields)
    : table_id(table_id),
      io_cost_per_page(io_cost_per_page),
      num_pages(num_pages),
      num_fields(num_fields),
      total_tuples(10200)  // 固定值
{
    histograms.resize(num_fields, nullptr);
    std::vector<int64_t> min_vals(num_fields, 0);
    std::vector<int64_t> max_vals(num_fields, 31);
    for (size_t i = 0; i < num_fields; i++) {
        int64_t range = max_vals[i] - min_vals[i] + 1;
        int64_t actual_buckets = (range < NUM_HIST_BINS) ? range : NUM_HIST_BINS;
        histograms[i] = new IntHistogram(actual_buckets, min_vals[i], max_vals[i]);
    }
    uint64_t range = static_cast<uint64_t>(max_vals[0] - min_vals[0] + 1);
    for (uint64_t i = 0; i < total_tuples; i++) {
        for (size_t j = 0; j < num_fields; j++) {
            int64_t val = (i % range) + min_vals[j];
            histograms[j]->add_value(val);
        }
    }
}

TableStats::TableStats(const TableStats& other)
    : table_id(other.table_id),
      io_cost_per_page(other.io_cost_per_page),
      num_pages(other.num_pages),
      num_fields(other.num_fields),
      total_tuples(other.total_tuples) {
    histograms.resize(other.histograms.size());
    for (size_t i = 0; i < other.histograms.size(); ++i) {
        if (other.histograms[i] != nullptr) {
            histograms[i] = new IntHistogram(*other.histograms[i]);
        } else {
            histograms[i] = nullptr;
        }
    }
}

TableStats& TableStats::operator=(TableStats other) {
    swap(*this, other);
    return *this;
}

void swap(TableStats& first, TableStats& second) {
    using std::swap;
    swap(first.table_id, second.table_id);
    swap(first.io_cost_per_page, second.io_cost_per_page);
    swap(first.num_pages, second.num_pages);
    swap(first.num_fields, second.num_fields);
    swap(first.total_tuples, second.total_tuples);
    swap(first.histograms, second.histograms);
}

double TableStats::estimate_selectivity(int64_t field, PredicateType op, int64_t constant) {
    if (field < 0 || field >= static_cast<int64_t>(num_fields)) return 1.0;
    return histograms[field]->estimate_selectivity(op, constant);
}

double TableStats::estimate_scan_cost() { return num_pages * io_cost_per_page; }

uint64_t TableStats::estimate_table_cardinality(double selectivity_factor) {
    return static_cast<uint64_t>(total_tuples * selectivity_factor);
}

}  // namespace table_stats
}  // namespace buzzdb
