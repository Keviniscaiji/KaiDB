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
CMAKE_SOURCE_DIR = /workspaces/buzzdb-2/build/vendor/gtm/src/googletest/googletest

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /workspaces/buzzdb-2/build/vendor/gtm/src/gtest_src-build

# Include any dependencies generated for this target.
include CMakeFiles/gtest.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/gtest.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/gtest.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/gtest.dir/flags.make

CMakeFiles/gtest.dir/src/gtest-all.cc.o: CMakeFiles/gtest.dir/flags.make
CMakeFiles/gtest.dir/src/gtest-all.cc.o: /workspaces/buzzdb-2/build/vendor/gtm/src/googletest/googletest/src/gtest-all.cc
CMakeFiles/gtest.dir/src/gtest-all.cc.o: CMakeFiles/gtest.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/workspaces/buzzdb-2/build/vendor/gtm/src/gtest_src-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/gtest.dir/src/gtest-all.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/gtest.dir/src/gtest-all.cc.o -MF CMakeFiles/gtest.dir/src/gtest-all.cc.o.d -o CMakeFiles/gtest.dir/src/gtest-all.cc.o -c /workspaces/buzzdb-2/build/vendor/gtm/src/googletest/googletest/src/gtest-all.cc

CMakeFiles/gtest.dir/src/gtest-all.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gtest.dir/src/gtest-all.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /workspaces/buzzdb-2/build/vendor/gtm/src/googletest/googletest/src/gtest-all.cc > CMakeFiles/gtest.dir/src/gtest-all.cc.i

CMakeFiles/gtest.dir/src/gtest-all.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gtest.dir/src/gtest-all.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /workspaces/buzzdb-2/build/vendor/gtm/src/googletest/googletest/src/gtest-all.cc -o CMakeFiles/gtest.dir/src/gtest-all.cc.s

# Object files for target gtest
gtest_OBJECTS = \
"CMakeFiles/gtest.dir/src/gtest-all.cc.o"

# External object files for target gtest
gtest_EXTERNAL_OBJECTS =

libgtest.a: CMakeFiles/gtest.dir/src/gtest-all.cc.o
libgtest.a: CMakeFiles/gtest.dir/build.make
libgtest.a: CMakeFiles/gtest.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/workspaces/buzzdb-2/build/vendor/gtm/src/gtest_src-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libgtest.a"
	$(CMAKE_COMMAND) -P CMakeFiles/gtest.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gtest.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/gtest.dir/build: libgtest.a
.PHONY : CMakeFiles/gtest.dir/build

CMakeFiles/gtest.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/gtest.dir/cmake_clean.cmake
.PHONY : CMakeFiles/gtest.dir/clean

CMakeFiles/gtest.dir/depend:
	cd /workspaces/buzzdb-2/build/vendor/gtm/src/gtest_src-build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /workspaces/buzzdb-2/build/vendor/gtm/src/googletest/googletest /workspaces/buzzdb-2/build/vendor/gtm/src/googletest/googletest /workspaces/buzzdb-2/build/vendor/gtm/src/gtest_src-build /workspaces/buzzdb-2/build/vendor/gtm/src/gtest_src-build /workspaces/buzzdb-2/build/vendor/gtm/src/gtest_src-build/CMakeFiles/gtest.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/gtest.dir/depend

