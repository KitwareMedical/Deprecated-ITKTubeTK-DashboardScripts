##############################################################################
#
# Library:   ITKTubeTK
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


##############################################################################
#
# Dashboard configuration
#
##############################################################################

# Follow format for caps and components as given on ITKTubeTK dashboard
set( SITE_NAME "NIH_Amazon_RHEL" )   
set( SITE_PLATFORM "RHEL-7.5-64-EXAMPLES_AS_TESTS-EXTERNAL" )

if( "${SITE_BUILD_TYPE}" STREQUAL "" )
  set( SITE_BUILD_TYPE "Release" ) # Release, Debug
endif( "${SITE_BUILD_TYPE}" STREQUAL "" )

if( "${SITE_CTEST_MODE}" STREQUAL "" )
  set( SITE_CTEST_MODE "Experimental" ) # Experimental, Continuous, or Nightly
endif( "${SITE_CTEST_MODE}" STREQUAL "" )

set( SITE_CMAKE_GENERATOR "Unix Makefiles" ) # Ninja or Unix Makefiles

set( TubeTK_GIT_REPOSITORY "https://github.com/KitwareMedical/ITKTubeTK.git" )

set( TubeTK_SOURCE_DIR
  "/home/ec2-user/src/ITKTubeTK" )
set( TubeTK_BINARY_DIR
  "/home/ec2-user/src/ITKTubeTK-${SITE_BUILD_TYPE}" )

# If a linux machine, allow qt-based tests to open a window on the display
set( ENV{DISPLAY} ":0" )


##############################################################################
#
# Machine-specific command paths
#
##############################################################################

set( SITE_MAKE_COMMAND "make -j8" )

set( SITE_CMAKE_COMMAND "/usr/bin/cmake" )
set( SITE_CTEST_COMMAND "/usr/bin/ctest -j8" )

set( SITE_COVERAGE_COMMAND "/usr/bin/gcov" )
set( SITE_MEMORYCHECK_COMMAND "/usr/bin/valgrind" )

set( SITE_GIT_COMMAND "/usr/bin/git" )


###########################################################################
#
# The following libraries are not handled by Superbuild.
#   If you want to use them, they must already be installed on your system.
#
###########################################################################

set( TubeTK_BUILD_USING_SLICER OFF )
#set( Slicer_DIR "/home/ubuntu/src/Slicer-Release/Slicer-build" )
#set( SITE_SVN_COMMAND "/usr/bin/svn" )

set( TubeTK_USE_BOOST OFF )
#set( BOOST_ROOT "/usr/local" )

set( TubeTK_USE_ARRAYFIRE OFF )
#set( ArrayFire_DIR "/usr/local" )

set( TubeTK_USE_VALGRIND ON )

set( TubeTK_USE_PYTHON ON )
set( TubeTK_USE_NUMPY_STACK ON )
set( TubeTK_USE_PYQTGRAPH ON )

#RHEL requires that we specify python3.4
set( PYTHON_EXECUTABLE "/usr/bin/python3.4" )
set( PYTHON_INCLUDE_DIR "/usr/include/python3.4m" )
set( PYTHON_LIBRARY "/usr/lib64/libpython3.4m.so.1.0" )

###########################################################################
#
# The following will be built using Superbuild, unless otherwise specified.
#
###########################################################################

set( TubeTK_USE_CPPCHECK ON )
set( USE_SYSTEM_CPPCHECK OFF )
#set( Cppcheck_DIR "" )

set( TubeTK_USE_JSONCPP ON )
set( USE_SYSTEM_JSONCPP OFF )
#set( JsonCpp_DIR "" )

set( TubeTK_USE_KWSTYLE ON )
set( USE_SYSTEM_KWSTYLE OFF )
#set( KWStyle_DIR "" )

set( TubeTK_USE_LIBSVM OFF )
set( USE_SYSTEM_LIBSVM OFF )
#set( LIBSVM_DIR "" )

set( TubeTK_USE_RANDOMFOREST OFF )
set( USE_SYSTEM_RANDOMFOREST OFF )
#set( RandomForest_DIR "" )

set( TubeTK_USE_VTK ON )
set( USE_SYSTEM_VTK ON )
set( VTK_DIR "/home/ec2-user/build/VTK-build" )
message( "VTK_DIR = ${VTK_DIR}" )

set( USE_SYSTEM_ITK ON )
set( ITK_DIR "/home/ec2-user/build/ITK-build" )

set( USE_SYSTEM_SLICER_EXECUTION_MODEL OFF )
#set( SlicerExecutionModel_DIR "" )


###########################################################################
#
# Standard configuration variables
#
###########################################################################

# To work with Slicer and ITK, TubeTK must be built with shared libs
set( BUILD_SHARED_LIBS ON )

# If build testing is on, some test data will download during building, and
#   some will download during testing.
set( BUILD_TESTING ON )

# If build applications is on, the applications will be built
set( TubeTK_BUILD_APPLICATIONS ON )

# Tests are run in a python virtual environment, if this variable on
set( BUILD_TESTING_VIRTUAL_ENV ON )

# Extends the time required for testing.
set( TubeTK_USE_EXAMPLES_AS_TESTS ON )


###########################################################################
#
# Configure what is run on this machine for experimental, continuous, and 
#   nightly builds
#
###########################################################################

set( SITE_EXPERIMENTAL_BUILD ON )
set( SITE_EXPERIMENTAL_TEST ON )
set( SITE_EXPERIMENTAL_CPPCHECK ON )
set( SITE_EXPERIMENTAL_KWSTYLE OFF )
set( SITE_EXPERIMENTAL_COVERAGE OFF )
set( SITE_EXPERIMENTAL_MEMORY OFF )
set( SITE_EXPERIMENTAL_BUILD_DOCUMENTATION OFF )
set( SITE_EXPERIMENTAL_PACKAGE OFF )
set( SITE_EXPERIMENTAL_UPLOAD OFF )

set( SITE_CONTINUOUS_BUILD ON )
set( SITE_CONTINUOUS_TEST ON )
if( "${SITE_BUILD_TYPE}" STREQUAL "Debug" )
  set( SITE_CONTINUOUS_CPPCHECK OFF )
  set( SITE_CONTINUOUS_KWSTYLE OFF )
else( "${SITE_BUILD_TYPE}" STREQUAL "Debug" )
  set( SITE_CONTINUOUS_CPPCHECK ON )
  set( SITE_CONTINUOUS_KWSTYLE ON )
endif( "${SITE_BUILD_TYPE}" STREQUAL "Debug" )
set( SITE_CONTINUOUS_COVERAGE OFF )
set( SITE_CONTINUOUS_MEMORY OFF )
set( SITE_CONTINUOUS_BUILD_DOCUMENTATION OFF )
set( SITE_CONTINUOUS_PACKAGE ON )
set( SITE_CONTINUOUS_UPLOAD ON )

set( SITE_NIGHTLY_BUILD ON )
set( SITE_NIGHTLY_TEST ON )
if( "${SITE_BUILD_TYPE}" STREQUAL "Debug" )
  set( SITE_NIGHTLY_CPPCHECK OFF )
  set( SITE_NIGHTLY_KWSTYLE OFF )
  set( SITE_NIGHTLY_COVERAGE ON )
  set( SITE_NIGHTLY_MEMORY ON )
else( "${SITE_BUILD_TYPE}" STREQUAL "Debug" )
  set( SITE_NIGHTLY_CPPCHECK ON )
  set( SITE_NIGHTLY_KWSTYLE ON )
  set( SITE_NIGHTLY_COVERAGE OFF )
  set( SITE_NIGHTLY_MEMORY OFF )
endif( "${SITE_BUILD_TYPE}" STREQUAL "Debug" )
set( SITE_NIGHTLY_BUILD_DOCUMENTATION OFF )
set( SITE_NIGHTLY_PACKAGE ON )
set( SITE_NIGHTLY_UPLOAD ON )

##############################################################################
# The following advanced variables should only be changed by experts.
##############################################################################

set( TubeTK_SCRIPT_DIR "${CTEST_SCRIPT_DIRECTORY}" )

set( SITE_BUILD_NAME "${SITE_PLATFORM}-${SITE_BUILD_TYPE}" )

set( SITE_UPDATE_COMMAND "${SITE_GIT_COMMAND}" )

set( SITE_MEMORYCHECK_COMMAND_OPTIONS
  "--gen-suppressions=all --trace-children=yes -q --leak-check=yes --show-reachable=yes --num-callers=50" )
set( SITE_MEMORYCHECK_SUPPRESSIONS_FILE
  "${TubeTK_SOURCE_DIR}/CMake/Valgrind/TubeTKValgrindSuppressions.txt" )

set( CTEST_SITE "${SITE_NAME}" )

set( CTEST_BUILD_CONFIGURATION "${SITE_BUILD_TYPE}" )
set( CTEST_CONFIGURATION_TYPE "${SITE_BUILD_TYPE}" )
set( CTEST_BUILD_COMMAND "${SITE_MAKE_COMMAND}" )

set( CTEST_SOURCE_DIRECTORY "${TubeTK_SOURCE_DIR}" )
set( CTEST_BINARY_DIRECTORY "${TubeTK_BINARY_DIR}/TubeTK-build" )

set( CTEST_CMAKE_GENERATOR "${SITE_CMAKE_GENERATOR}" )

set( CTEST_CMAKE_COMMAND "${SITE_CMAKE_COMMAND}" )
set( CTEST_CTEST_COMMAND "${SITE_CTEST_COMMAND}" )
set( CTEST_UPDATE_COMMAND "${SITE_UPDATE_COMMAND}" )
set( CTEST_COVERAGE_COMMAND "${SITE_COVERAGE_COMMAND}" )
set( CTEST_MEMORYCHECK_COMMAND "${SITE_MEMORYCHECK_COMMAND}" )
set( CTEST_MEMORYCHECK_COMMAND_OPTIONS "${SITE_MEMORYCHECK_COMMAND_OPTIONS}" )
set( CTEST_MEMORYCHECK_SUPPRESSIONS_FILE
  "${SITE_MEMORYCHECK_SUPPRESSIONS_FILE}" )
set( CTEST_COMMAND "${SITE_CTEST_COMMAND}" )

if( SITE_NIGHTLY_MEMORY OR SITE_CONTINUOUS_MEMORY OR
    SITE_EXPERIMENTAL_MEMORY )
  set( CTEST_TEST_TIMEOUT 3600 )
else( SITE_NIGHTLY_MEMORY OR SITE_CONTINUOUS_MEMORY OR
      SITE_EXPERIMENTAL_MEMORY )
  set( CTEST_TEST_TIMEOUT 360 )
endif( SITE_NIGHTLY_MEMORY OR SITE_CONTINUOUS_MEMORY OR
       SITE_EXPERIMENTAL_MEMORY )

set( SITE_CXX_FLAGS
  "-fPIC -fdiagnostics-show-option -W -Wall -Wextra -Wshadow -Wno-system-headers -Wwrite-strings -Wno-deprecated -Woverloaded-virtual" )
set( SITE_C_FLAGS
  "-fPIC -fdiagnostics-show-option -W -Wall -Wextra -Wshadow -Wno-system-headers -Wwrite-strings" )
set( SITE_EXE_LINKER_FLAGS "" )
set( SITE_SHARED_LINKER_FLAGS "" )

set( COVERAGE_FLAGS "-fprofile-arcs -ftest-coverage -lgcov" )
if( SITE_NIGHTLY_COVERAGE OR SITE_CONTINUOUS_COVERAGE OR
    SITE_EXPERIMENTAL_COVERAGE )
  set( SITE_C_FLAGS "${SITE_C_FLAGS} ${COVERAGE_FLAGS}" )
  set( SITE_CXX_FLAGS "${SITE_CXX_FLAGS} ${COVERAGE_FLAGS}" )
  set( SITE_EXE_LINKER_FLAGS "${SITE_EXE_LINKER_FLAGS} ${COVERAGE_FLAGS}" )
  set( SITE_SHARED_LINKER_FLAGS
    "${SITE_SHARED_LINKER_FLAGS} ${COVERAGE_FLAGS}" )
endif( SITE_NIGHTLY_COVERAGE OR SITE_CONTINUOUS_COVERAGE OR
       SITE_EXPERIMENTAL_COVERAGE )

set( MEMORYCHECK_FLAGS "-g -O0 -ggdb" )
if( SITE_NIGHTLY_MEMORY OR SITE_CONTINUOUS_MEMORY OR
    SITE_EXPERIMENTAL_MEMORY )
  set( SITE_C_FLAGS "${SITE_C_FLAGS} ${MEMORYCHECK_FLAGS}" )
  set( SITE_CXX_FLAGS "${SITE_CXX_FLAGS} ${MEMORYCHECK_FLAGS}" )
endif( SITE_NIGHTLY_MEMORY OR SITE_CONTINUOUS_MEMORY OR
       SITE_EXPERIMENTAL_MEMORY )

set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${SITE_C_FLAGS}" )
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SITE_CXX_FLAGS}" )
set( CMAKE_EXE_LINKER_FLAGS
  "${CMAKE_EXE_LINKER_FLAGS} ${SITE_EXE_LINKER_FLAGS}" )
set( CMAKE_SHARED_LINKER_FLAGS
  "${CMAKE_SHARED_LINKER_FLAGS} ${SITE_SHARED_LINKER_FLAGS}" )

set( GITCOMMAND "${SITE_GIT_COMMAND}" )
set( GIT_EXECUTABLE "${SITE_GIT_COMMAND}" )
if( TubeTK_BUILD_USING_SLICER )
  set( Subversion_SVN_EXECUTABLE "${SITE_SVN_COMMAND}" )
endif( TubeTK_BUILD_USING_SLICER )
set( CMAKE_GENERATOR ${SITE_CMAKE_GENERATOR} )

if( NOT EXISTS "${TubeTK_SOURCE_DIR}/CMakeLists.txt" )
  execute_process( COMMAND
    "${SITE_GIT_COMMAND}"
    clone "${TubeTK_GIT_REPOSITORY}" "${TubeTK_SOURCE_DIR}" )
endif( NOT EXISTS "${TubeTK_SOURCE_DIR}/CMakeLists.txt" )

if( "${SITE_CTEST_MODE}" STREQUAL "Experimental" )
  include( "${TubeTK_SCRIPT_DIR}/run_experimental.cmake" )
elseif( "${SITE_CTEST_MODE}" STREQUAL "Continuous" )
  include( "${TubeTK_SCRIPT_DIR}/run_continuous.cmake" )
elseif( "${SITE_CTEST_MODE}" STREQUAL "Nightly" )
  include( "${TubeTK_SCRIPT_DIR}/run_nightly.cmake" )
endif( "${SITE_CTEST_MODE}" STREQUAL "Experimental" )
