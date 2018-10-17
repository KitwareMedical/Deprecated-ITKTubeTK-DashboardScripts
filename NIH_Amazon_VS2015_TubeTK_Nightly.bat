REM Start from a clean build directory
rmdir /Q /S C:\d\ITKTubeTK-Build-Release

REM Set environment variables
set ITK_BUILD_DIR=C:\d\ITKTubeTk-Superbuild\ITK-build
set TubeTK_BUILD_DIR=C:\d\ITKTubeTK-Build-Release\TubeTK-build

REM Update the ITKTubeTK Dashboard scripts
cd C:\d\ITKTubeTK-DashboardScripts
SETLOCAL
IF /i NOT "%~dp0"=="%temp%\" (
  "C:\Program Files\Git\cmd\git" reset --hard HEAD
  "C:\Program Files\Git\cmd\git" pull
  COPY /y "NIH_Amazon_VS2015_TubeTK_Nightly.bat" "%temp%\NIH_Amazon_VS2015_TubeTK_Nightly.bat" >nul
  "%temp%\NIH_Amazon_VS2015_TubeTK_Nightly.bat"
  del "%temp%\NIH_Amazon_VS2015_TubeTK_Nightly.bat"
  exit /B
)
ENDLOCAL

del C:\d\NIH_Amazon_VS2015_TubeTK_Nightly.bat.old
rename C:\d\NIH_Amazon_VS2015_TubeTK_Nightly.bat NIH_Amazon_VS2015_TubeTK_Nightly.bat.old
copy NIH_Amazon_VS2015_TubeTK_Nightly.bat C:\d\NIH_Amazon_VS2015_TubeTK_Nightly.bat
cd ..

REM Run the nightly CTest
"C:\Program Files\CMake\bin\ctest.exe" -D Nightly -D SITE_CTEST_MODE:STRING=Nightly -D SITE_BUILD_TYPE:STRING=Release -S "C:\d\ITKTubeTK-DashboardScripts\NIH_Amazon_VS2015_TubeTK.cmake" -C Release -V -VV -O "C:\d\NIH_Amazon_VS2015_TubeTK_Nightly.log"

REM Run the continuous CTest
"C:\Program Files\CMake\bin\ctest.exe" -D Continuous -D SITE_CTEST_MODE:STRING=Continuous -D SITE_BUILD_TYPE:STRING=Release -S "C:\d\ITKTubeTK-DashboardScripts\NIH_Amazon_VS2015_TubeTK.cmake" -C Release -V -VV -O "C:\d\NIH_Amazon_VS2015_TubeTK.log"
