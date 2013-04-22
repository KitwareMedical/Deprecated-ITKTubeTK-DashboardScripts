##############################################################################
#
# Library:   TubeTK
#
# Copyright 2010 Kitware Inc. 28 Corporate Drive,
# Clifton Park, NY, 12065, USA.
#
# All rights reserved.
#
# Licensed under the Apache License, Version 2.0 ( the "License" );
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

##############################################################################
#
# Configure the following variables and move this file to the directory above
#   the TubeTK source directory.
#
set( SITE_NAME "Hippo.Kitware" )
set( SITE_PLATFORM "apple-darwin12.3.0-clang-x86_64" )
set( SITE_BUILD_TYPE "RelWithDebInfo" )
set( SITE_CTEST_MODE "Nightly" )
set( SITE_CMAKE_GENERATOR "Unix Makefiles" )

set( TUBETK_GIT_REPOSITORY "http://tubetk.org/TubeTK.git" )
set( TUBETK_ROOT_DIR "/Users/snape/Development/TubeTK" )
set( TUBETK_DASHBOARDS_DIR "${TUBETK_ROOT_DIR}/TubeTK-Dashboards" )
set( TUBETK_SOURCE_DIR "${TUBETK_ROOT_DIR}/TubeTK-${SITE_CTEST_MODE}" )
set( TUBETK_BINARY_DIR "${TUBETK_ROOT_DIR}/TubeTK-${SITE_CTEST_MODE}-${SITE_BUILD_TYPE}" )

set( ENV{DISPLAY} ":0" )

set( SITE_MAKE_COMMAND "/usr/bin/make" )
set( SITE_CMAKE_COMMAND "/usr/local/bin/cmake" )
set( SITE_QMAKE_COMMAND "/usr/local/bin/qmake" )
set( SITE_CTEST_COMMAND "/usr/local/bin/ctest" )

set( SITE_MEMORYCHECK_COMMAND "/usr/local/bin/valgrind" )
set( SITE_COVERAGE_COMMAND "/usr/bin/gcov" )
set( SITE_KWSTYLE_DIR "/usr/local/bin" )

set( SITE_GIT_COMMAND "/usr/bin/git" )
set( SITE_SVN_COMMAND "/usr/bin/svn" )

set( SITE_EXPERIMENTAL_BUILD ON )
set( SITE_EXPERIMENTAL_TEST ON )
set( SITE_EXPERIMENTAL_COVERAGE OFF )
set( SITE_EXPERIMENTAL_MEMORY OFF )
set( SITE_EXPERIMENTAL_PACKAGE OFF )
set( SITE_EXPERIMENTAL_UPLOAD OFF )
set( SITE_EXPERIMENTAL_DOCUMENTATION OFF )
set( SITE_EXPERIMENTAL_STYLE OFF )
set( SITE_EXPERIMENTAL_CPPCHECK OFF )

set( SITE_CONTINUOUS_BUILD ON )
set( SITE_CONTINUOUS_TEST ON )
set( SITE_CONTINUOUS_COVERAGE OFF )
set( SITE_CONTINUOUS_MEMORY OFF )
set( SITE_CONTINUOUS_PACKAGE OFF )
set( SITE_CONTINUOUS_UPLOAD OFF )
set( SITE_CONTINUOUS_DOCUMENTATION OFF )
set( SITE_CONTINUOUS_STYLE OFF )
set( SITE_CONTINUOUS_CPPCHECK OFF )

set( SITE_NIGHTLY_BUILD ON )
set( SITE_NIGHTLY_TEST ON )
set( SITE_NIGHTLY_COVERAGE OFF )
set( SITE_NIGHTLY_MEMORY OFF )
set( SITE_NIGHTLY_PACKAGE ON )
set( SITE_NIGHTLY_UPLOAD ON )
set( SITE_NIGHTLY_DOCUMENTATION OFF )
set( SITE_NIGHTLY_STYLE OFF )
set( SITE_NIGHTLY_CPPCHECK OFF )

##############################################################################

##############################################################################
#
# The following advanced variables should only be changed by experts
#
set( TUBETK_SCRIPT_DIR "${TUBETK_SOURCE_DIR}/CMake" )

set( SITE_BUILD_NAME "${SITE_PLATFORM}-${SITE_BUILD_TYPE}" )

set( SITE_UPDATE_COMMAND "${SITE_GIT_COMMAND}" )

set( CTEST_SITE "${SITE_NAME}" )

set( CTEST_BUILD_CONFIGURATION "${SITE_BUILD_TYPE}" )
set( CTEST_BUILD_COMMAND "${SITE_MAKE_COMMAND}" )

set( CTEST_SOURCE_DIRECTORY "${TUBETK_SOURCE_DIR}" )
set( CTEST_BINARY_DIRECTORY "${TUBETK_BINARY_DIR}/TubeTK-Build" )

set( CTEST_CMAKE_GENERATOR "${SITE_CMAKE_GENERATOR}" )
set( CTEST_TEST_TIMEOUT 1500 )

set( CTEST_CMAKE_COMMAND "${SITE_CMAKE_COMMAND}" )
set( CTEST_CTEST_COMMAND "${SITE_CTEST_COMMAND}" )
set( CTEST_UPDATE_COMMAND "${SITE_UPDATE_COMMAND}" )
set( CTEST_COVERAGE_COMMAND "${SITE_COVERAGE_COMMAND}" )
set( CTEST_MEMORYCHECK_COMMAND "${SITE_MEMORYCHECK_COMMAND}" )
set( CTEST_MEMORYCHECK_COMMAND_OPTIONS "${SITE_MEMORYCHECK_COMMAND_OPTIONS}" )
set( CTEST_MEMORYCHECK_SUPPRESSIONS_FILE "${SITE_MEMORYCHECK_SUPPRESSIONS_FILE}" )
set( CTEST_COMMAND "${SITE_CTEST_COMMAND}" )

set( SITE_EXECUTABLE_DIRS "${SITE_KWSTYLE_DIR}" )
set( ENV{PATH} "${SITE_EXECUTABLE_DIRS}:$ENV{PATH}" )

set( SITE_C_FLAGS "-fPIC -fdiagnostics-show-option -W -Wall -Wextra -Wshadow -Wno-system-headers -Wwrite-strings -Wno-deprecated -Wno-deprecated-declarations -Wno-incompatible-pointer-types -Wno-invalid-source-encoding -Wno-sometimes-uninitialized" )
set( SITE_CXX_FLAGS "-fPIC -fdiagnostics-show-option -W -Wall -Wextra -Wshadow -Wno-system-headers -Wwrite-strings -Wno-deprecated -Wno-deprecated-declarations -Wno-incompatible-pointer-types -Wno-invalid-source-encoding -Wno-sometimes-uninitialized -Woverloaded-virtual -Wno-unused-private-field" )
set( SITE_EXE_LINKER_FLAGS "" )
set( SITE_SHARED_LINKER_FLAGS "${SITE_EXE_LINKER_FLAGS}" )

set( COVERAGE_C_FLAGS "-g -O0 -fprofile-arcs -ftest-coverage" )
set( COVERAGE_CXX_FLAGS "${COVERAGE_C_FLAGS}" )
set( COVERAGE_EXE_LINKER_FLAGS "" )
set( COVERAGE_SHARED_LINKER_FLAGS "${COVERAGE_EXE_LINKER_FLAGS}" )

if( SITE_NIGHTLY_COVERAGE OR SITE_CONTINUOUS_COVERAGE OR SITE_EXPERIMENTAL_COVERAGE )
  set( SITE_C_FLAGS "${SITE_C_FLAGS} ${COVERAGE_C_FLAGS}" )
  set( SITE_CXX_FLAGS "${SITE_CXX_FLAGS} ${COVERAGE_CXX_FLAGS}" )
  set( SITE_EXE_LINKER_FLAGS "${SITE_EXE_LINKER_FLAGS} ${COVERAGE_EXE_LINKER_FLAGS}" )
  set( SITE_SHARED_LINKER_FLAGS "${SITE_SHARED_LINKER_FLAGS} ${COVERAGE_SHARED_LINKER_FLAGS}" )
endif( SITE_NIGHTLY_COVERAGE OR SITE_CONTINUOUS_COVERAGE OR SITE_EXPERIMENTAL_COVERAGE )

set( SITE_MEMORYCHECK_COMMAND_OPTIONS "--gen-suppressions=all --trace-children=yes -q --leak-check=yes --show-reachable=yes --num-callers=50" )
set( SITE_MEMORYCHECK_SUPPRESSIONS_FILE "${TUBETK_SCRIPT_DIR}/valgrind_suppressions.txt" )

set( MEMORYCHECK_C_FLAGS "-g -O0 -ggdb" )
set( MEMORYCHECK_CXX_FLAGS "${MEMORYCHECK_C_FLAGS}" )

if( SITE_NIGHTLY_MEMORY OR SITE_CONTINUOUS_MEMORY OR SITE_EXPERIMENTAL_MEMORY )
  set( SITE_C_FLAGS "${SITE_C_FLAGS} ${MEMORYCHECK_C_FLAGS}" )
  set( SITE_CXX_FLAGS "${SITE_CXX_FLAGS} ${MEMORYCHECK_CXX_FLAGS}" )
endif( SITE_NIGHTLY_MEMORY OR SITE_CONTINUOUS_MEMORY OR SITE_EXPERIMENTAL_MEMORY )

set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${SITE_C_FLAGS}" )
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SITE_CXX_FLAGS}" )
set( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${SITE_EXE_LINKER_FLAGS}" )
set( CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${SITE_SHARED_LINKER_FLAGS}" )

set( GITCOMMAND "${SITE_GIT_COMMAND}" )
set( GIT_EXECUTABLE "${SITE_GIT_COMMAND}" )
set( SVNCOMMAND "${SITE_SVN_COMMAND}" )
set( CMAKE_GENERATOR "${SITE_CMAKE_GENERATOR}" )
set( QT_QMAKE_EXECUTABLE "${SITE_QMAKE_COMMAND}" )
set( TubeTK_USE_Boost ON )

if( NOT EXISTS "${TUBETK_SOURCE_DIR}/CMakeLists.txt" )
  execute_process( COMMAND "${SITE_GIT_COMMAND}" clone "${TUBETK_GIT_REPOSITORY}" "${TUBETK_SOURCE_DIR}" )
  ctest_run_script()
endif( NOT EXISTS "${TUBETK_SOURCE_DIR}/CMakeLists.txt" )

if( "${SITE_CTEST_MODE}" STREQUAL "Experimental" )
  include( "${TUBETK_DASHBOARDS_DIR}/run_experimental.cmake" )
elseif( "${SITE_CTEST_MODE}" STREQUAL "Continuous" )
  include( "${TUBETK_DASHBOARDS_DIR}/run_continuous.cmake" )
elseif( "${SITE_CTEST_MODE}" STREQUAL "Nightly" )
  include( "${TUBETK_DASHBOARDS_DIR}/run_nightly.cmake" )
endif()
