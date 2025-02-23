#include "external_sort/external_sort.h"

#include <algorithm>
#include <cassert>
#include <cmath>
#include <functional>
#include <iostream>
#include <map>
#include <queue>
#include <thread>
#include <vector>

#include "storage/file.h"

#define UNUSED(p) ((void)(p))
using namespace std;

namespace buzzdb {

struct KthMergeElement {
    uint64_t value;
    size_t chunk_id;
    bool operator>(const KthMergeElement &other) const { return value > other.value; }
};

void external_sort(File &input, size_t num_values, File &output, size_t mem_size) {
    const size_t kElementSize = sizeof(uint64_t);
    size_t elements_per_chunk = mem_size / kElementSize;
    vector<unique_ptr<File>> temp_files;
    vector<size_t> temp_file_sizes;
    size_t input_offset = 0;
    unique_ptr<uint64_t[]> input_buffer(new uint64_t[elements_per_chunk]);

    for (size_t remaining = num_values; remaining > 0;) {
        size_t current_chunk_size = min(elements_per_chunk, remaining);
        size_t bytes_to_read = current_chunk_size * kElementSize;
        input.read_block(input_offset * kElementSize, bytes_to_read,
                         reinterpret_cast<char *>(input_buffer.get()));
        sort(input_buffer.get(), input_buffer.get() + current_chunk_size);
        auto temp_file = File::make_temporary_file();
        temp_file->resize(bytes_to_read);
        temp_file->write_block(reinterpret_cast<char *>(input_buffer.get()), 0, bytes_to_read);
        temp_files.push_back(move(temp_file));
        temp_file_sizes.push_back(current_chunk_size);
        input_offset += current_chunk_size;
        remaining -= current_chunk_size;
    }

    size_t num_chunks = temp_files.size();
    output.resize(num_values * kElementSize);
    vector<unique_ptr<uint64_t[]>> chunk_data(num_chunks);
    for (size_t i = 0; i < num_chunks; i++) {
        size_t chunk_size = temp_file_sizes[i];
        chunk_data[i].reset(new uint64_t[chunk_size]);
        temp_files[i]->read_block(0, chunk_size * kElementSize,
                                  reinterpret_cast<char *>(chunk_data[i].get()));
    }

    vector<size_t> indices_in_chunk(num_chunks, 0);
    priority_queue<KthMergeElement, vector<KthMergeElement>, greater<KthMergeElement>> min_heap;

    for (size_t i = 0; i < num_chunks; i++) {
        if (temp_file_sizes[i] > 0) {
            KthMergeElement elem{chunk_data[i][0], i};
            min_heap.push(elem);
        }
    }

    size_t total_written = 0;

    while (!min_heap.empty()) {
        auto smallest = min_heap.top();
        min_heap.pop();
        output.write_block(reinterpret_cast<const char *>(&smallest.value),
                           total_written * kElementSize, kElementSize);
        total_written++;
        size_t chunk_id = smallest.chunk_id;
        indices_in_chunk[chunk_id]++;
        if (indices_in_chunk[chunk_id] < temp_file_sizes[chunk_id]) {
            uint64_t next_val = chunk_data[chunk_id][indices_in_chunk[chunk_id]];
            min_heap.push({next_val, chunk_id});
        }
    }
}

}  // namespace buzzdb