# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /workspaces/buzzdb-2

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /workspaces/buzzdb-2/build

# Include any dependencies generated for this target.
include CMakeFiles/external_sort_test_valgrind.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/external_sort_test_valgrind.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/external_sort_test_valgrind.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/external_sort_test_valgrind.dir/flags.make

CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.o: CMakeFiles/external_sort_test_valgrind.dir/flags.make
CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.o: ../test/unit/external_sort/external_sort_test.cc
CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.o: CMakeFiles/external_sort_test_valgrind.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/workspaces/buzzdb-2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.o -MF CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.o.d -o CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.o -c /workspaces/buzzdb-2/test/unit/external_sort/external_sort_test.cc

CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /workspaces/buzzdb-2/test/unit/external_sort/external_sort_test.cc > CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.i

CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /workspaces/buzzdb-2/test/unit/external_sort/external_sort_test.cc -o CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.s

# Object files for target external_sort_test_valgrind
external_sort_test_valgrind_OBJECTS = \
"CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.o"

# External object files for target external_sort_test_valgrind
external_sort_test_valgrind_EXTERNAL_OBJECTS =

test/external_sort_test_valgrind: CMakeFiles/external_sort_test_valgrind.dir/test/unit/external_sort/external_sort_test.cc.o
test/external_sort_test_valgrind: CMakeFiles/external_sort_test_valgrind.dir/build.make
test/external_sort_test_valgrind: libbuzzdb.a
test/external_sort_test_valgrind: vendor/gtm/gtest/lib/libgtest.a
test/external_sort_test_valgrind: vendor/gtm/gmock/lib/libgmock.a
test/external_sort_test_valgrind: vendor/gflags/lib/libgflags.a
test/external_sort_test_valgrind: CMakeFiles/external_sort_test_valgrind.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/workspaces/buzzdb-2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable test/external_sort_test_valgrind"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/external_sort_test_valgrind.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/external_sort_test_valgrind.dir/build: test/external_sort_test_valgrind
.PHONY : CMakeFiles/external_sort_test_valgrind.dir/build

CMakeFiles/external_sort_test_valgrind.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/external_sort_test_valgrind.dir/cmake_clean.cmake
.PHONY : CMakeFiles/external_sort_test_valgrind.dir/clean

CMakeFiles/external_sort_test_valgrind.dir/depend:
	cd /workspaces/buzzdb-2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /workspaces/buzzdb-2 /workspaces/buzzdb-2 /workspaces/buzzdb-2/build /workspaces/buzzdb-2/build /workspaces/buzzdb-2/build/CMakeFiles/external_sort_test_valgrind.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/external_sort_test_valgrind.dir/depend

