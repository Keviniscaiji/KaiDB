
if(NOT "/workspaces/buzzdb-2/build/vendor/rapidjson/src/rapidjson_src-stamp/rapidjson_src-gitinfo.txt" IS_NEWER_THAN "/workspaces/buzzdb-2/build/vendor/rapidjson/src/rapidjson_src-stamp/rapidjson_src-gitclone-lastrun.txt")
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: '/workspaces/buzzdb-2/build/vendor/rapidjson/src/rapidjson_src-stamp/rapidjson_src-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rm -rf "/workspaces/buzzdb-2/build/vendor/rapidjson/src/rapidjson_src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: '/workspaces/buzzdb-2/build/vendor/rapidjson/src/rapidjson_src'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "/usr/bin/git"  clone --no-checkout --config "advice.detachedHead=false" "https://github.com/tencent/rapidjson" "rapidjson_src"
    WORKING_DIRECTORY "/workspaces/buzzdb-2/build/vendor/rapidjson/src"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/tencent/rapidjson'")
endif()

execute_process(
  COMMAND "/usr/bin/git"  checkout v1.1.0 --
  WORKING_DIRECTORY "/workspaces/buzzdb-2/build/vendor/rapidjson/src/rapidjson_src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: 'v1.1.0'")
endif()

set(init_submodules TRUE)
if(init_submodules)
  execute_process(
    COMMAND "/usr/bin/git"  submodule update --recursive --init 
    WORKING_DIRECTORY "/workspaces/buzzdb-2/build/vendor/rapidjson/src/rapidjson_src"
    RESULT_VARIABLE error_code
    )
endif()
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: '/workspaces/buzzdb-2/build/vendor/rapidjson/src/rapidjson_src'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "/workspaces/buzzdb-2/build/vendor/rapidjson/src/rapidjson_src-stamp/rapidjson_src-gitinfo.txt"
    "/workspaces/buzzdb-2/build/vendor/rapidjson/src/rapidjson_src-stamp/rapidjson_src-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: '/workspaces/buzzdb-2/build/vendor/rapidjson/src/rapidjson_src-stamp/rapidjson_src-gitclone-lastrun.txt'")
endif()

