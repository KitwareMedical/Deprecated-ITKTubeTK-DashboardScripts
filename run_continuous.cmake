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

###########################################################################
# run some "inside-the-loop" continuous scripts for a while
#
while( ${CTEST_ELAPSED_TIME} LESS 68400 )

  set( START_TIME ${CTEST_ELAPSED_TIME} )

  set( CTEST_BUILD_NAME "${SITE_BUILD_NAME}-BuildTest-Continuous" )

  if( SITE_CONTINUOUS_DOCUMENTATION )
    set( BUILD_DOCUMENTATION ON )
    set( TubeTK_USE_DOXYGEN ON )
  else()
    set( BUILD_DOCUMENTATION OFF )
    set( TubeTK_USE_DOXYGEN OFF )
  endif()
  
  set( TubeTK_USE_KWSTYLE OFF )
  
  if( SITE_CONTINUOUS_BOOST )
    set( TubeTK_USE_Boost ON )
  else()
    set( TubeTK_USE_Boost OFF )
  endif( SITE_CONTINUOUS_BOOST )

  if( SITE_CONTINUOUS_CPPCHECK )
    set( TubeTK_USE_CPPCHECK ON )
  else()
    set( TubeTK_USE_CPPCHECK OFF )
  endif( SITE_CONTINUOUS_CPPCHECK )

  if( SITE_CONTINUOUS_CTK )
    set( TubeTK_USE_CTK ON )
  else()
    set( TubeTK_USE_CTK OFF )
  endif( SITE_CONTINUOUS_CTK )

  if( SITE_CONTINUOUS_LIBSVM )
    set( TubeTK_USE_LIBSVM ON )
  else()
    set( TubeTK_USE_LIBSVM OFF )
  endif( SITE_CONTINUOUS_LIBSVM )
  
  if( SITE_CONTINUOUS_QT )
    set( TubeTK_USE_QT ON )
  else()
    set( TubeTK_USE_QT OFF )
  endif( SITE_CONTINUOUS_QT )

  if( SITE_CONTINUOUS_SIMPLEITK )
    set( TubeTK_USE_SimpleITK ON )
  else()
    set( TubeTK_USE_SimpleITK OFF )
  endif( SITE_CONTINUOUS_SIMPLEITK )

  if( SITE_CONTINUOUS_VTK )
    set( TubeTK_USE_VTK ON )
  else()
    set( TubeTK_USE_VTK OFF )
  endif( SITE_CONTINUOUS_VTK )

  configure_file(
    ${TUBETK_SCRIPT_DIR}/InitCMakeCache.cmake.in
    ${TUBETK_BINARY_DIR}/InitCMakeCache.cmake IMMEDIATE @ONLY )
  set( CTEST_NOTES_FILES "${TUBETK_BINARY_DIR}/InitCMakeCache.cmake" )

  ctest_start( "Continuous" )

  ctest_update( SOURCE "${CTEST_SOURCE_DIRECTORY}" RETURN_VALUE res )

  if( res GREATER 0 OR res LESS 0 )


    if( SITE_CONTINUOUS_BUILD )
      ctest_configure( BUILD "${TUBETK_BINARY_DIR}"
        SOURCE "${TUBETK_SOURCE_DIR}"
        OPTIONS "-C${TUBETK_BINARY_DIR}/InitCMakeCache.cmake" )
      ctest_read_custom_files( "${TUBETK_BINARY_DIR}" )
      ctest_build( BUILD "${TUBETK_BINARY_DIR}" )
      ctest_submit( PARTS Notes Update Configure Build )
    else()
      ctest_read_custom_files( "${TUBETK_BINARY_DIR}" )
      ctest_submit( PARTS Notes Update )
    endif()

    if( SITE_CONTINUOUS_TEST )
      ctest_test( BUILD "${TUBETK_BINARY_DIR}/TubeTK-Build" )
      ctest_submit( PARTS Test )
    endif()

    if( SITE_CONTINUOUS_COVERAGE )
      ctest_coverage( BUILD "${TUBETK_BINARY_DIR}/TubeTK-Build" )
      ctest_submit( PARTS Coverage )
    endif()

    if( SITE_CONTINUOUS_MEMORY )
      ctest_memcheck( BUILD "${TUBETK_BINARY_DIR}/TubeTK-Build" )
      ctest_submit( PARTS MemCheck )
    endif()

    function( TubeTK_Package )
      execute_process(
        COMMAND ${CMAKE_COMMAND} --build ${TUBETK_BINARY_DIR}/TubeTK-Build --target package
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

    if( SITE_CONTINUOUS_PACKAGE )
      TubeTK_Package()
    endif()

    if( SITE_CONTINUOUS_UPLOAD )
      TubeTK_Upload()
    endif()

    function( TubeTK_Style )
      set( CTEST_BUILD_NAME "${SITE_BUILD_NAME}-Style-Nightly" )
      set( TubeTK_USE_KWSTYLE ON )
      configure_file(
        ${TUBETK_SCRIPT_DIR}/InitCMakeCache.cmake.in
        ${TUBETK_BINARY_DIR}/InitCMakeCache.cmake IMMEDIATE @ONLY )
      set( CTEST_NOTES_FILES "${TUBETK_BINARY_DIR}/InitCMakeCache.cmake" )
      ctest_start( "Nightly" )
      ctest_configure( BUILD "${TUBETK_BINARY_DIR}"
        SOURCE "${TUBETK_SOURCE_DIR}"
        OPTIONS "-C${TUBETK_BINARY_DIR}/InitCMakeCache.cmake" )
      ctest_read_custom_files( "${TUBETK_BINARY_DIR}" )
      execute_process(
        COMMAND ${CMAKE_COMMAND} --build ${TUBETK_BINARY_DIR}/TubeTK-Build --target StyleCheck
        WORKING_DIRECTORY ${TUBETK_BINARY_DIR}/TubeTK-Build
        )
      ctest_submit( PARTS configure build )
    endfunction( TubeTK_Style )

    if( SITE_CONTINUOUS_STYLE )
      TubeTK_Style()
    endif()

  endif()

  # loop no faster than once every 2 minutes
  ctest_sleep( ${START_TIME} 120 ${CTEST_ELAPSED_TIME} )

endwhile()

# do not run this script as a dashboard
set(CTEST_RUN_CURRENT_SCRIPT 0)
