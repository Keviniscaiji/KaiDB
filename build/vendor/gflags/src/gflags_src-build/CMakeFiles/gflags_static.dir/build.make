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
CMAKE_SOURCE_DIR = /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src-build

# Include any dependencies generated for this target.
include CMakeFiles/gflags_static.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/gflags_static.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/gflags_static.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/gflags_static.dir/flags.make

CMakeFiles/gflags_static.dir/src/gflags.cc.o: CMakeFiles/gflags_static.dir/flags.make
CMakeFiles/gflags_static.dir/src/gflags.cc.o: /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src/src/gflags.cc
CMakeFiles/gflags_static.dir/src/gflags.cc.o: CMakeFiles/gflags_static.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/gflags_static.dir/src/gflags.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/gflags_static.dir/src/gflags.cc.o -MF CMakeFiles/gflags_static.dir/src/gflags.cc.o.d -o CMakeFiles/gflags_static.dir/src/gflags.cc.o -c /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src/src/gflags.cc

CMakeFiles/gflags_static.dir/src/gflags.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gflags_static.dir/src/gflags.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src/src/gflags.cc > CMakeFiles/gflags_static.dir/src/gflags.cc.i

CMakeFiles/gflags_static.dir/src/gflags.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gflags_static.dir/src/gflags.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src/src/gflags.cc -o CMakeFiles/gflags_static.dir/src/gflags.cc.s

CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.o: CMakeFiles/gflags_static.dir/flags.make
CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.o: /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src/src/gflags_reporting.cc
CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.o: CMakeFiles/gflags_static.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.o -MF CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.o.d -o CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.o -c /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src/src/gflags_reporting.cc

CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src/src/gflags_reporting.cc > CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.i

CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src/src/gflags_reporting.cc -o CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.s

CMakeFiles/gflags_static.dir/src/gflags_completions.cc.o: CMakeFiles/gflags_static.dir/flags.make
CMakeFiles/gflags_static.dir/src/gflags_completions.cc.o: /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src/src/gflags_completions.cc
CMakeFiles/gflags_static.dir/src/gflags_completions.cc.o: CMakeFiles/gflags_static.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/gflags_static.dir/src/gflags_completions.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/gflags_static.dir/src/gflags_completions.cc.o -MF CMakeFiles/gflags_static.dir/src/gflags_completions.cc.o.d -o CMakeFiles/gflags_static.dir/src/gflags_completions.cc.o -c /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src/src/gflags_completions.cc

CMakeFiles/gflags_static.dir/src/gflags_completions.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gflags_static.dir/src/gflags_completions.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src/src/gflags_completions.cc > CMakeFiles/gflags_static.dir/src/gflags_completions.cc.i

CMakeFiles/gflags_static.dir/src/gflags_completions.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gflags_static.dir/src/gflags_completions.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src/src/gflags_completions.cc -o CMakeFiles/gflags_static.dir/src/gflags_completions.cc.s

# Object files for target gflags_static
gflags_static_OBJECTS = \
"CMakeFiles/gflags_static.dir/src/gflags.cc.o" \
"CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.o" \
"CMakeFiles/gflags_static.dir/src/gflags_completions.cc.o"

# External object files for target gflags_static
gflags_static_EXTERNAL_OBJECTS =

lib/libgflags.a: CMakeFiles/gflags_static.dir/src/gflags.cc.o
lib/libgflags.a: CMakeFiles/gflags_static.dir/src/gflags_reporting.cc.o
lib/libgflags.a: CMakeFiles/gflags_static.dir/src/gflags_completions.cc.o
lib/libgflags.a: CMakeFiles/gflags_static.dir/build.make
lib/libgflags.a: CMakeFiles/gflags_static.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX static library lib/libgflags.a"
	$(CMAKE_COMMAND) -P CMakeFiles/gflags_static.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gflags_static.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/gflags_static.dir/build: lib/libgflags.a
.PHONY : CMakeFiles/gflags_static.dir/build

CMakeFiles/gflags_static.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/gflags_static.dir/cmake_clean.cmake
.PHONY : CMakeFiles/gflags_static.dir/clean

CMakeFiles/gflags_static.dir/depend:
	cd /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src-build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src-build /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src-build /workspaces/buzzdb-2/build/vendor/gflags/src/gflags_src-build/CMakeFiles/gflags_static.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/gflags_static.dir/depend

