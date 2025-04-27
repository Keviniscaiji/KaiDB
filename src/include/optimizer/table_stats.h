#pragma once
#include <cassert>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <vector>

#include "operators/seq_scan.h"

using buzzdb::operators::PredicateType;

namespace buzzdb {
namespace table_stats {

// 管理整数直方图的类
class IntHistogram {
   public:
    // 禁止默认构造函数
    IntHistogram() = delete;

    // 构造函数
    IntHistogram(int64_t buckets, int64_t min_val, int64_t max_val);

    // 拷贝构造函数，实现深拷贝（vector 会自动做深拷贝）
    IntHistogram(const IntHistogram& other);

    // 添加数值
    void add_value(int64_t val);

    // 估计谓词选择性
    double estimate_selectivity(PredicateType op, int64_t v);

   private:
    int64_t buckets;
    int64_t min_val;
    int64_t max_val;
    double bucket_width;
    int64_t total;
    std::vector<int64_t> counts;
};

// 管理表统计信息的类
class TableStats {
   public:
    // 析构函数：释放直方图内存
    ~TableStats() {
        for (auto hist : histograms) {
            delete hist;
        }
    }

    // 默认构造函数
    TableStats()
        : table_id(0),
          io_cost_per_page(1),
          num_pages(0),
          num_fields(0),
          total_tuples(0),
          histograms() {}

    // 参数化构造函数
    TableStats(int64_t table_id, int64_t io_cost_per_page, uint64_t num_pages, uint64_t num_fields);

    // 自定义拷贝构造函数，实现深拷贝
    TableStats(const TableStats& other);

    // 拷贝赋值运算符：采用拷贝-交换实现
    TableStats& operator=(TableStats other);

    // 交换函数，供拷贝赋值运算符使用
    friend void swap(TableStats& first, TableStats& second);

    // 根据字段的谓词与常量估计选择性
    double estimate_selectivity(int64_t field, PredicateType op, int64_t constant);

    // 估计扫描代价
    double estimate_scan_cost();

    // 估计表基数
    uint64_t estimate_table_cardinality(double selectivity_factor);

   private:
    int NUM_HIST_BINS = 100;
    int64_t table_id;
    int64_t io_cost_per_page;
    uint64_t num_pages;
    uint64_t num_fields;
    uint64_t total_tuples;
    std::vector<IntHistogram*> histograms;
};

}  // namespace table_stats
}  // namespace buzzdb
