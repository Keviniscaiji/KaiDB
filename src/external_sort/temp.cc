#include <algorithm>
#include <cassert>
#include <cmath>
#include <functional>
#include <iostream>
#include <map>
#include <queue>
#include <thread>
#include <vector>

#include "external_sort/external_sort.h"
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

    for (size_t remaining_values = num_values; remaining_values > 0;) {
        size_t current_chunk_size = min(elements_per_chunk, remaining_values);
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
        remaining_values -= current_chunk_size;
    }

    size_t num_chunks = temp_files.size();
    size_t buffer_size_per_chunk = elements_per_chunk / (num_chunks + 1);
    vector<unique_ptr<uint64_t[]>> chunk_buffers(num_chunks);
    vector<size_t> chunk_buffer_filled(num_chunks, 0);
    vector<size_t> chunk_buffer_indices(num_chunks, 0);
    vector<size_t> chunk_global_indices(num_chunks, 0);

    for (size_t i = 0; i < num_chunks; i++) {
        chunk_buffers[i] = make_unique<uint64_t[]>(buffer_size_per_chunk);
        size_t to_read = min(buffer_size_per_chunk, temp_file_sizes[i]);
        size_t bytes_to_read = to_read * kElementSize;
        if (bytes_to_read > 0) {
            temp_files[i]->read_block(0, bytes_to_read,
                                      reinterpret_cast<char *>(chunk_buffers[i].get()));
        }
        chunk_buffer_filled[i] = to_read;
    }

    size_t total_written = 0;
    priority_queue<KthMergeElement, vector<KthMergeElement>, greater<KthMergeElement>> min_heap;

    for (size_t i = 0; i < num_chunks; i++) {
        if (chunk_buffer_filled[i] > 0) {
            min_heap.push({chunk_buffers[i][0], i});
        }
    }

    output.resize(num_values * kElementSize);

    auto refill_chunk_buffer = [&](size_t chunk_id) {
        chunk_buffer_indices[chunk_id] = 0;
        size_t consumed = chunk_buffer_filled[chunk_id];
        chunk_global_indices[chunk_id] += consumed;
        size_t remaining = temp_file_sizes[chunk_id] - chunk_global_indices[chunk_id];
        if (remaining == 0) {
            chunk_buffer_filled[chunk_id] = 0;
            return;
        }
        size_t to_read = min(buffer_size_per_chunk, remaining);
        size_t file_offset = chunk_global_indices[chunk_id] * kElementSize;
        size_t bytes_to_read = to_read * kElementSize;
        temp_files[chunk_id]->read_block(file_offset, bytes_to_read,
                                         reinterpret_cast<char *>(chunk_buffers[chunk_id].get()));
        chunk_buffer_filled[chunk_id] = to_read;
    };

    while (!min_heap.empty()) {
        auto smallest = min_heap.top();
        min_heap.pop();
        output.write_block(reinterpret_cast<const char *>(&smallest.value),
                           total_written * kElementSize, kElementSize);
        total_written++;
        size_t chunk_id = smallest.chunk_id;
        chunk_buffer_indices[chunk_id]++;
        if (chunk_buffer_indices[chunk_id] < chunk_buffer_filled[chunk_id]) {
            min_heap.push({chunk_buffers[chunk_id][chunk_buffer_indices[chunk_id]], chunk_id});
        } else {
            refill_chunk_buffer(chunk_id);
            if (chunk_buffer_filled[chunk_id] > 0) {
                min_heap.push({chunk_buffers[chunk_id][0], chunk_id});
            }
        }
    }
}

}  // namespace buzzdb