# CMake generated Testfile for 
# Source directory: /workspaces/buzzdb-2
# Build directory: /workspaces/buzzdb-2/build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(external_sort_test "/workspaces/buzzdb-2/build/test/external_sort_test" "--gtest_color=yes" "--gtest_output=xml:/workspaces/buzzdb-2/build/test/unit_external_sort_test.xml")
set_tests_properties(external_sort_test PROPERTIES  _BACKTRACE_TRIPLES "/workspaces/buzzdb-2/test/CMakeLists.txt;55;add_test;/workspaces/buzzdb-2/test/CMakeLists.txt;0;;/workspaces/buzzdb-2/CMakeLists.txt;73;include;/workspaces/buzzdb-2/CMakeLists.txt;0;")
add_test(external_sort_test_valgrind "/usr/bin/valgrind" "--error-exitcode=1" "--leak-check=full" "--soname-synonyms=somalloc=*jemalloc*" "--trace-children=yes" "--track-origins=yes" "--suppressions=/workspaces/buzzdb-2/script/valgrind.supp" "/workspaces/buzzdb-2/build/test/external_sort_test_valgrind" "--gtest_color=yes" "--gtest_output=xml:/workspaces/buzzdb-2/build/test/unit_external_sort_test_valgrind.xml")
set_tests_properties(external_sort_test_valgrind PROPERTIES  _BACKTRACE_TRIPLES "/workspaces/buzzdb-2/test/CMakeLists.txt;62;add_test;/workspaces/buzzdb-2/test/CMakeLists.txt;0;;/workspaces/buzzdb-2/CMakeLists.txt;73;include;/workspaces/buzzdb-2/CMakeLists.txt;0;")
