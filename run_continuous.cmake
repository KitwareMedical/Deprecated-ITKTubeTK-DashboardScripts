##############################################################################
#
# Library:   TubeTK
#
# Copyright 2010 Kitware Inc. 28 Corporate Drive,
# Clifton Park, NY, 12065, USA.
#
# All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
##############################################################################

# Run some "inside-the-loop" continuous scripts for a while.

while( ${CTEST_ELAPSED_TIME} LESS 68400 )
  set( START_TIME ${CTEST_ELAPSED_TIME} )

  set( CTEST_BUILD_NAME "${SITE_BUILD_NAME}-BuildTest-Continuous" )

  if( BUILD_DOCUMENTATION )
    set( TubeTK_USE_DOXYGEN ON )
  endif( BUILD_DOCUMENTATION )

  if( SITE_CONTINUOUS_CPPCHECK )
    set( TubeTK_USE_CPPCHECK ON )
  else
    set( TubeTK_USE_CPPCHECK OFF )
  endif( SITE_CONTINUOUS_CPPCHECK )

  if( SITE_CONTINUOUS_KWSTYLE )
    set( TubeTK_USE_KWSTYLE ON )
  else
    set( TubeTK_USE_KWSTYLE OFF )
  endif( SITE_CONTINUOUS_KWSTYLE )

  set( BUILD_TESTING ON )

  configure_file( ${TubeTK_SOURCE_DIR}/CMake/InitCMakeCache.cmake.in
    ${TubeTK_BINARY_DIR}/InitCMakeCache.cmake IMMEDIATE @ONLY )
  set( CTEST_NOTES_FILES "${TubeTK_BINARY_DIR}/InitCMakeCache.cmake" )

  ctest_start( "Continuous" )

  ctest_update( SOURCE "${CTEST_SOURCE_DIRECTORY}" RETURN_VALUE res )

  if( res GREATER 0 OR res LESS 0 )
    if( SITE_CONTINUOUS_BUILD )
      ctest_configure( BUILD "${TubeTK_BINARY_DIR}"
        SOURCE "${TubeTK_SOURCE_DIR}"
        OPTIONS "-C${TubeTK_BINARY_DIR}/InitCMakeCache.cmake" )
      ctest_read_custom_files( "${TubeTK_BINARY_DIR}" )
      ctest_build( BUILD "${TubeTK_BINARY_DIR}" )
      ctest_submit( PARTS Notes Update Configure Build )
    else( SITE_CONTINUOUS_BUILD )
      ctest_read_custom_files( "${TubeTK_BINARY_DIR}" )
      ctest_submit( PARTS Notes Update )
    endif( SITE_CONTINUOUS_BUILD )

    if( SITE_CONTINUOUS_TEST )
      ctest_test( BUILD "${TubeTK_BINARY_DIR}/TubeTK-build" )
      ctest_submit( PARTS Test )
    endif( SITE_CONTINUOUS_TEST )

    if( SITE_CONTINUOUS_COVERAGE )
      ctest_coverage( BUILD "${TubeTK_BINARY_DIR}/TubeTK-build" )
      ctest_submit( PARTS Coverage )
    endif( SITE_CONTINUOUS_COVERAGE )

    if( SITE_CONTINUOUS_MEMORY )
      ctest_memcheck( BUILD "${TubeTK_BINARY_DIR}/TubeTK-build" )
      ctest_submit( PARTS MemCheck )
    endif( SITE_CONTINUOUS_MEMORY )

    if( SITE_CONTINUOUS_PACKAGE )
      execute_process( COMMAND ${CMAKE_COMMAND}
          --build ${TubeTK_BINARY_DIR}/TubeTK-build
          --target package
        WORKING_DIRECTORY ${TubeTK_BINARY_DIR}/TubeTK-build
        OUTPUT_STRIP_TRAILING_WHITESPACE
        OUTPUT_FILE CPackOutputFiles.txt )
    endif( SITE_CONTINUOUS_PACKAGE )

    if( SITE_CONTINUOUS_UPLOAD )
      set( package_list )
      set( regexp ".*CPack: - package: (.*) generated\\." )
      set( raw_package_list )
      file( STRINGS ${TubeTK_BINARY_DIR}/TubeTK-build/CPackOutputFiles.txt raw_package_list REGEX ${regexp} )
      foreach( package ${raw_package_list} )
        string( REGEX REPLACE ${regexp} "\\1" package_path "${package}" )
        list( APPEND package_list ${package_path} )
      endforeach( package ${raw_package_list} )
      ctest_upload( FILES ${package_list} )
      ctest_submit( PARTS Upload )
    endif( SITE_CONTINUOUS_UPLOAD )

    if( SITE_CONTINUOUS_KWSTYLE )
      set( CTEST_BUILD_NAME "${SITE_BUILD_NAME}-Style-Continuous" )
      configure_file( ${TubeTK_SCRIPT_DIR}/InitCMakeCache.cmake.in
        ${TubeTK_BINARY_DIR}/InitCMakeCache.cmake IMMEDIATE @ONLY )
      set( CTEST_NOTES_FILES "${TubeTK_BINARY_DIR}/InitCMakeCache.cmake" )
      ctest_start( "Continuous" )
      ctest_configure( BUILD "${TubeTK_BINARY_DIR}"
        SOURCE "${TubeTK_SOURCE_DIR}"
        OPTIONS "-C${TubeTK_BINARY_DIR}/InitCMakeCache.cmake" )
      ctest_read_custom_files( "${TubeTK_BINARY_DIR}" )
      execute_process( COMMAND ${CMAKE_COMMAND}
          --build ${TubeTK_BINARY_DIR}/TubeTK-build
          --target StyleCheck
        WORKING_DIRECTORY ${TubeTK_BINARY_DIR}/TubeTK-build )
      ctest_submit()
    endif( SITE_CONTINUOUS_KWSTYLE )

  endif( res GREATER 0 OR res LESS 0 )

  # Loop no faster than once every 2 minutes.
  ctest_sleep( ${START_TIME} 120 ${CTEST_ELAPSED_TIME} )

endwhile( ${CTEST_ELAPSED_TIME} LESS 68400 )

set( CTEST_RUN_CURRENT_SCRIPT 0 )
