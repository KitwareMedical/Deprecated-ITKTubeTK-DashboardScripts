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
else()
  set( BUILD_DOCUMENTATION OFF )
  set( TubeTK_USE_DOXYGEN OFF )
endif()

set( TubeTK_USE_KWSTYLE OFF )

if( SITE_EXPERIMENTAL_CPPCHECK )
  set( TubeTK_USE_CPPCHECK ON )
else()
  set( TubeTK_USE_CPPCHECK OFF )
endif()

if( SITE_EXPERIMENTAL_BOOST )
  set( TubeTK_USE_Boost ON )
else()
  set( TubeTK_USE_Boost OFF )
endif()

configure_file(
  ${TUBETK_SCRIPT_DIR}/InitCMakeCache.cmake.in
  ${TUBETK_BINARY_DIR}/InitCMakeCache.cmake IMMEDIATE @ONLY )
set( CTEST_NOTES_FILES "${TUBETK_BINARY_DIR}/InitCMakeCache.cmake" )

ctest_start( "Experimental" )

if( SITE_EXPERIMENTAL_BUILD )
  #ctest_update( SOURCE "${TUBETK_SOURCE_DIR}" )
  ctest_configure( BUILD "${TUBETK_BINARY_DIR}"
    SOURCE "${TUBETK_SOURCE_DIR}"
    OPTIONS "-C${TUBETK_BINARY_DIR}/InitCMakeCache.cmake" )
  ctest_read_custom_files( "${TUBETK_BINARY_DIR}" )
  ctest_build( BUILD "${TUBETK_BINARY_DIR}" )
  #ctest_submit( PARTS Notes Update Configure Build )
  ctest_submit( PARTS Notes Configure Build )
else()
  ctest_read_custom_files( "${TUBETK_BINARY_DIR}" )
  ctest_submit( PARTS Notes )
endif()

if( SITE_EXPERIMENTAL_TEST )
  ctest_test( BUILD "${TUBETK_BINARY_DIR}/TubeTK-Build" )
  ctest_submit( PARTS Test )
endif()

if( SITE_EXPERIMENTAL_COVERAGE )
  ctest_coverage( BUILD "${TUBETK_BINARY_DIR}/TubeTK-Build" )
  ctest_submit( PARTS Coverage )
endif()

if( SITE_EXPERIMENTAL_MEMORY )
  ctest_memcheck( BUILD "${TUBETK_BINARY_DIR}/TubeTK-Build" )
  ctest_submit( PARTS MemCheck )
endif()

function( TubeTK_Package )
  execute_process(
    COMMAND ${CMAKE_COMMAND} --build ${TUBETK_BINARY_DIR}/TubeTK-Build --target package --config ${CTEST_BUILD_CONFIGURATION}
    WORKING_DIRECTORY ${TUBETK_BINARY_DIR}/TubeTK-Build
    OUTPUT_STRIP_TRAILING_WHITESPACE
    OUTPUT_FILE CPackOutputFiles.txt
    )
endfunction( TubeTK_Package )

function( TubeTK_Upload )
  set(package_list)
  set(regexp ".*CPack: - package: (.*) generated\\.")
  set(raw_package_list)
  file(STRINGS ${TUBETK_BINARY_DIR}/TubeTK-Build/CPackOutputFiles.txt raw_package_list REGEX ${regexp})
  foreach(package ${raw_package_list})
    string(REGEX REPLACE ${regexp} "\\1" package_path "${package}" )
    list(APPEND package_list ${package_path})
  endforeach()
  ctest_upload( FILES ${package_list} )
  ctest_submit( PARTS Upload )
endfunction( TubeTK_Upload )

if( SITE_EXPERIMENTAL_PACKAGE )
  TubeTK_Package()
endif()

if( SITE_EXPERIMENTAL_UPLOAD )
  TubeTK_Upload()
endif()

function( TubeTK_Style )
  set( CTEST_BUILD_NAME "${SITE_BUILD_NAME}-Style-Experimental" )
  set( TubeTK_USE_KWSTYLE ON )
  configure_file(
    ${TUBETK_SCRIPT_DIR}/InitCMakeCache.cmake.in
    ${TUBETK_BINARY_DIR}/InitCMakeCache.cmake IMMEDIATE @ONLY )
  set( CTEST_NOTES_FILES "${TUBETK_BINARY_DIR}/InitCMakeCache.cmake" )
  ctest_start( "Experimental" )
  ctest_configure( BUILD "${TUBETK_BINARY_DIR}"
    SOURCE "${TUBETK_SOURCE_DIR}"
    OPTIONS "-C${TUBETK_BINARY_DIR}/InitCMakeCache.cmake" )
  ctest_read_custom_files( "${TUBETK_BINARY_DIR}" )
  execute_process(
    COMMAND ${CMAKE_COMMAND} --build ${TUBETK_BINARY_DIR}/TubeTK-Build --target StyleCheck --config ${CTEST_BUILD_CONFIGURATION}
    WORKING_DIRECTORY ${TUBETK_BINARY_DIR}/TubeTK-Build
    )
  ctest_submit( PARTS configure build )
endfunction( TubeTK_Style )

if( SITE_EXPERIMENTAL_STYLE )
  TubeTK_Style()
endif()

set(CTEST_RUN_CURRENT_SCRIPT 0)
