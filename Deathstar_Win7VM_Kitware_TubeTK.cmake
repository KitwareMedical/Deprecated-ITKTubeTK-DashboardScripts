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

set( SITE_NAME "deathstar.win7VM.kitware.com" )
set( SITE_PLATFORM "Windows7-VS2010-64" )
if( NOT SITE_BUILD_TYPE )
  set( SITE_BUILD_TYPE "Release" )
endif( NOT SITE_BUILD_TYPE )
if( NOT SITE_CTEST_MODE )
  set( SITE_CTEST_MODE "Nightly" ) # one of Experimental, Continuous, Nightly
endif( NOT SITE_CTEST_MODE )
set( SITE_CMAKE_GENERATOR "Visual Studio 10 Win64" )

set( TubeTK_GIT_REPOSITORY "https://github.com/TubeTK/TubeTK.git" )
set( TubeTK_SOURCE_DIR "C:/Dashboards/TubeTK/TubeTK" )
set( TubeTK_BINARY_DIR "C:/Dashboards/TubeTK/TubeTK-${SITE_BUILD_TYPE}" )

set( TubeTK_USE_BOOST OFF )
set( TubeTK_USE_CTK OFF )
set( TubeTK_USE_IMAGE_VIEWER OFF )
set( TubeTK_USE_LIBSVM OFF )
set( TubeTK_USE_NOTEBOOKS OFF )
set( TubeTK_USE_NUMPY OFF )
set( TubeTK_USE_PYTHON OFF )
set( TubeTK_USE_PYQTGRAPH OFF )
set( TubeTK_USE_QT OFF )
set( TubeTK_USE_SIMPLEITK OFF )
set( TubeTK_USE_SLICER OFF )
set( TubeTK_USE_VTK ON )

set( USE_SYSTEM_CTK OFF )
set( USE_SYSTEM_IMAGE_VIEWER OFF )
set( USE_SYSTEM_ITK OFF )
set( USE_SYSTEM_JSONCPP OFF )
set( USE_SYSTEM_LIBSVM OFF )
set( USE_SYSTEM_PARAMETER_SERIALIZER OFF )
set( USE_SYSTEM_SIMPLEITK OFF )
set( USE_SYSTEM_SLICER OFF )
set( USE_SYSTEM_SLICER_EXECUTION_MODEL OFF )
set( USE_SYSTEM_VTK OFF )

set( BUILD_DOCUMENTATION OFF )
set( BUILD_SHARED_LIBS ON )

set( SITE_MAKE_COMMAND "${CTEST_BUILD_COMMAND}" )
set( SITE_CMAKE_COMMAND "C:/Program Files/CMake 2.8/bin/cmake" )
set( SITE_QMAKE_COMMAND "C:/Users/matt/Qt474/bin/qmake" )
set( SITE_CTEST_COMMAND "C:/Program Files/CMake 2.8/bin/ctest" )

set( SITE_MEMORYCHECK_COMMAND "" )
set( SITE_COVERAGE_COMMAND "" )
set( SITE_KWSTYLE_DIR "" )

set( SITE_GIT_COMMAND "C:/Program Files (x86)/Git/bin/git" )
set( SITE_SVN_COMMAND "C:/Program Files (x86)/Subversion/bin/svn" )

set( SITE_EXPERIMENTAL_BUILD ON )
set( SITE_EXPERIMENTAL_TEST ON )
set( SITE_EXPERIMENTAL_CPPCHECK OFF )
set( SITE_EXPERIMENTAL_KWSTYLE OFF )
set( SITE_EXPERIMENTAL_COVERAGE OFF )
set( SITE_EXPERIMENTAL_MEMORY OFF )
set( SITE_EXPERIMENTAL_PACKAGE OFF )
set( SITE_EXPERIMENTAL_UPLOAD OFF )

set( SITE_CONTINUOUS_BUILD ON )
set( SITE_CONTINUOUS_TEST ON )
set( SITE_CONTINUOUS_CPPCHECK OFF )
set( SITE_CONTINUOUS_KWSTYLE OFF )
set( SITE_CONTINUOUS_COVERAGE OFF )
set( SITE_CONTINUOUS_MEMORY OFF )
set( SITE_CONTINUOUS_PACKAGE OFF )
set( SITE_CONTINUOUS_UPLOAD OFF )

set( SITE_NIGHTLY_BUILD ON )
set( SITE_NIGHTLY_TEST ON )
set( SITE_NIGHTLY_CPPCHECK OFF )
set( SITE_NIGHTLY_KWSTYLE OFF )
set( SITE_NIGHTLY_COVERAGE OFF )
set( SITE_NIGHTLY_MEMORY OFF )
set( SITE_NIGHTLY_PACKAGE ON )
set( SITE_NIGHTLY_UPLOAD ON )

##############################################################################
# The following advanced variables should only be changed by experts.
##############################################################################

set( TubeTK_SCRIPT_DIR "${CTEST_SCRIPT_DIRECTORY}" )

set( SITE_BUILD_NAME "${SITE_PLATFORM}-${SITE_BUILD_TYPE}" )

set( SITE_UPDATE_COMMAND "${SITE_GIT_COMMAND}" )

set( CTEST_SITE "${SITE_NAME}" )

set( CTEST_BUILD_CONFIGURATION "${SITE_BUILD_TYPE}" )
set( CTEST_BUILD_COMMAND "${SITE_MAKE_COMMAND}" )

set( CTEST_SOURCE_DIRECTORY "${TubeTK_SOURCE_DIR}" )
set( CTEST_BINARY_DIRECTORY "${TubeTK_BINARY_DIR}/TubeTK-build" )

set( CTEST_CMAKE_GENERATOR "${SITE_CMAKE_GENERATOR}" )
set( CTEST_TEST_TIMEOUT 1500 )

set( CTEST_CMAKE_COMMAND "${SITE_CMAKE_COMMAND}" )
set( CTEST_CTEST_COMMAND "${SITE_CTEST_COMMAND}" )
set( CTEST_UPDATE_COMMAND "${SITE_UPDATE_COMMAND}" )
set( CTEST_COVERAGE_COMMAND "${SITE_COVERAGE_COMMAND}" )
set( CTEST_MEMORYCHECK_COMMAND "${SITE_MEMORYCHECK_COMMAND}" )
set( CTEST_MEMORYCHECK_COMMAND_OPTIONS
  "${SITE_MEMORYCHECK_COMMAND_OPTIONS}" )
set( CTEST_MEMORYCHECK_SUPPRESSIONS_FILE
  "${SITE_MEMORYCHECK_SUPPRESSIONS_FILE}" )
set( CTEST_COMMAND "${SITE_CTEST_COMMAND}" )

set( SITE_EXECUTABLE_DIRS "${TubeTK_BINARY_DIR}/ModuleDescriptionParser-build/${SITE_BUILD_TYPE};${TubeTK_BINARY_DIR}/GenerateCLP-build/${SITE_BUILD_TYPE};${TubeTK_BINARY_DIR}/ITK-build/bin/${SITE_BUILD_TYPE};${TubeTK_BINARY_DIR}/VTK-build/bin/${SITE_BUILD_TYPE};${TubeTK_BINARY_DIR}/TubeTK-build/bin/${SITE_BUILD_TYPE};${TubeTK_BINARY_DIR}/TubeTK-build/lib/TubeTK/Plugins/${SITE_BUILD_TYPE}" )
set( ENV{PATH} "${SITE_EXECUTABLE_DIRS};$ENV{PATH}" )

set( SITE_CXX_FLAGS "/DWIN32 /D_WINDOWS /W3 /Zm1000 /GR /MP /EHsc" )
set( SITE_C_FLAGS "/DWIN32 /D_WINDOWS /W3 /Zm1000 /MP" )
set( SITE_EXE_LINKER_FLAGS "" )
set( SITE_SHARED_LINKER_FLAGS "" )

set( SITE_MEMORYCHECK_COMMAND_OPTIONS "" )
set( SITE_MEMORYCHECK_SUPPRESSIONS_FILE
  "${TubeTK_SCRIPT_DIR}/valgrind_suppressions.txt" )

set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${SITE_C_FLAGS}" )
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SITE_CXX_FLAGS}" )
set( CMAKE_EXE_LINKER_FLAGS
  "${CMAKE_EXE_LINKER_FLAGS} ${SITE_EXE_LINKER_FLAGS}" )
set( CMAKE_SHARED_LINKER_FLAGS
  "${CMAKE_SHARED_LINKER_FLAGS} ${SITE_SHARED_LINKER_FLAGS}" )

set( GITCOMMAND "${SITE_GIT_COMMAND}" )
set( GIT_EXECUTABLE "${SITE_GIT_COMMAND}" )
set( SVNCOMMAND "${SITE_SVN_COMMAND}" )
set( CMAKE_GENERATOR ${SITE_CMAKE_GENERATOR} )
set( QT_QMAKE_EXECUTABLE "${SITE_QMAKE_COMMAND}" )

if( NOT EXISTS "${TubeTK_SOURCE_DIR}/CMakeLists.txt" )
  execute_process( COMMAND
    "${SITE_GIT_COMMAND}"
    clone "${TubeTK_GIT_REPOSITORY}" "${TubeTK_SOURCE_DIR}" )
  ctest_run_script()
endif( NOT EXISTS "${TubeTK_SOURCE_DIR}/CMakeLists.txt" )

if( "${SITE_CTEST_MODE}" STREQUAL "Experimental" )
  include( "${TubeTK_SCRIPT_DIR}/run_experimental.cmake" )
elseif( "${SITE_CTEST_MODE}" STREQUAL "Continuous" )
  include( "${TubeTK_SCRIPT_DIR}/run_continuous.cmake" )
elseif( "${SITE_CTEST_MODE}" STREQUAL "Nightly" )
  include( "${TubeTK_SCRIPT_DIR}/run_nightly.cmake" )
endif( "${SITE_CTEST_MODE}" STREQUAL "Experimental" )
