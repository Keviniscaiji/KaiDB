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

# Utility rule file for check-tools.

# Include any custom commands dependencies for this target.
include CMakeFiles/check-tools.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/check-tools.dir/progress.make

check-tools: CMakeFiles/check-tools.dir/build.make
.PHONY : check-tools

# Rule to build all files generated by this target.
CMakeFiles/check-tools.dir/build: check-tools
.PHONY : CMakeFiles/check-tools.dir/build

CMakeFiles/check-tools.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/check-tools.dir/cmake_clean.cmake
.PHONY : CMakeFiles/check-tools.dir/clean

CMakeFiles/check-tools.dir/depend:
	cd /workspaces/buzzdb-2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /workspaces/buzzdb-2 /workspaces/buzzdb-2 /workspaces/buzzdb-2/build /workspaces/buzzdb-2/build /workspaces/buzzdb-2/build/CMakeFiles/check-tools.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/check-tools.dir/depend

