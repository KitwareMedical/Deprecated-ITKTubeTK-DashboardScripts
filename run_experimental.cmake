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

set( CTEST_BUILD_NAME "${SITE_BUILD_NAME}-BuildTest-Experimental" )

if( SITE_EXPERIMENTAL_DOCUMENTATION )
  set( BUILD_DOCUMENTATION ON )
  set( TubeTK_USE_DOXYGEN ON )
else( SITE_EXPERIMENTAL_DOCUMENTATION )
  set( BUILD_DOCUMENTATION OFF )
  set( TubeTK_USE_DOXYGEN OFF )
endif( SITE_EXPERIMENTAL_DOCUMENTATION )

set( TubeTK_USE_KWSTYLE OFF )

if( SITE_EXPERIMENTAL_CPPCHECK )
  set( TubeTK_USE_CPPCHECK ON )
else( SITE_EXPERIMENTAL_CPPCHECK )
  set( TubeTK_USE_CPPCHECK OFF )
endif( SITE_EXPERIMENTAL_CPPCHECK )

configure_file( ${TubeTK_SOURCE_DIR}/CMake/InitCMakeCache.cmake.in
                ${TubeTK_BINARY_DIR}/InitCMakeCache.cmake IMMEDIATE @ONLY )
set( CTEST_NOTES_FILES "${TubeTK_BINARY_DIR}/InitCMakeCache.cmake" )

ctest_start( "Experimental" )

if( SITE_EXPERIMENTAL_BUILD )
  ctest_configure( BUILD "${TubeTK_BINARY_DIR}"
    SOURCE "${TubeTK_SOURCE_DIR}"
    OPTIONS "-C${TubeTK_BINARY_DIR}/InitCMakeCache.cmake" )
  ctest_read_custom_files( "${TubeTK_BINARY_DIR}" )
  ctest_build( BUILD "${TubeTK_BINARY_DIR}" )
  ctest_submit( PARTS Notes Configure Build )
else( SITE_EXPERIMENTAL_BUILD )
  ctest_read_custom_files( "${TubeTK_BINARY_DIR}" )
  ctest_submit( PARTS Notes )
endif( SITE_EXPERIMENTAL_BUILD )

if( SITE_EXPERIMENTAL_TEST )
  ctest_test( BUILD "${TubeTK_BINARY_DIR}/TubeTK-build" )
  ctest_submit( PARTS Test )
endif( SITE_EXPERIMENTAL_TEST )

if( SITE_EXPERIMENTAL_COVERAGE )
  ctest_coverage( BUILD "${TubeTK_BINARY_DIR}/TubeTK-build" )
  ctest_submit( PARTS Coverage )
endif( SITE_EXPERIMENTAL_COVERAGE )

if( SITE_EXPERIMENTAL_MEMORY )
  ctest_memcheck( BUILD "${TubeTK_BINARY_DIR}/TubeTK-build" )
  ctest_submit( PARTS MemCheck )
endif( SITE_EXPERIMENTAL_MEMORY )

function( TubeTK_Package )
  execute_process( COMMAND ${CMAKE_COMMAND}
                     --build ${TubeTK_BINARY_DIR}/TubeTK-build
                     --target package
                     --config ${CTEST_BUILD_CONFIGURATION}
    WORKING_DIRECTORY ${TubeTK_BINARY_DIR}/TubeTK-build
    OUTPUT_STRIP_TRAILING_WHITESPACE
    OUTPUT_FILE CPackOutputFiles.txt )
endfunction( TubeTK_Package )

function( TubeTK_Upload )
  set( package_list)
  set( regexp ".*CPack: - package: (.*) generated\\." )
  set( raw_package_list )
  file( STRINGS ${TubeTK_BINARY_DIR}/TubeTK-build/CPackOutputFiles.txt raw_package_list REGEX ${regexp} )
  foreach( package ${raw_package_list} )
    string( REGEX REPLACE ${regexp} "\\1" package_path "${package}" )
    list( APPEND package_list ${package_path} )
  endforeach( package ${raw_package_list} )
  ctest_upload( FILES ${package_list} )
  ctest_submit( PARTS Upload )
endfunction( TubeTK_Upload )

if( SITE_EXPERIMENTAL_PACKAGE )
  TubeTK_Package()
endif( SITE_EXPERIMENTAL_PACKAGE )

if( SITE_EXPERIMENTAL_UPLOAD )
  TubeTK_Upload()
endif( SITE_EXPERIMENTAL_UPLOAD )

function( TubeTK_Style )
  set( CTEST_BUILD_NAME "${SITE_BUILD_NAME}-Style-Experimental" )
  set( TubeTK_USE_KWSTYLE ON )
  configure_file( ${TubeTK_SCRIPT_DIR}/InitCMakeCache.cmake.in
                  ${TubeTK_BINARY_DIR}/InitCMakeCache.cmake IMMEDIATE @ONLY )
  set( CTEST_NOTES_FILES "${TubeTK_BINARY_DIR}/InitCMakeCache.cmake" )
  ctest_start( "Experimental" )
  ctest_configure( BUILD "${TubeTK_BINARY_DIR}"
    SOURCE "${TubeTK_SOURCE_DIR}"
    OPTIONS "-C${TubeTK_BINARY_DIR}/InitCMakeCache.cmake" )
  ctest_read_custom_files( "${TubeTK_BINARY_DIR}" )
  execute_process( COMMAND ${CMAKE_COMMAND}
                     --build ${TubeTK_BINARY_DIR}/TubeTK-build
                     --target StyleCheck
                     --config ${CTEST_BUILD_CONFIGURATION}
    WORKING_DIRECTORY ${TubeTK_BINARY_DIR}/TubeTK-build )
  ctest_submit( PARTS configure build )
endfunction( TubeTK_Style )

if( SITE_EXPERIMENTAL_STYLE )
  TubeTK_Style()
endif( SITE_EXPERIMENTAL_STYLE )

set( CTEST_RUN_CURRENT_SCRIPT 0 )
