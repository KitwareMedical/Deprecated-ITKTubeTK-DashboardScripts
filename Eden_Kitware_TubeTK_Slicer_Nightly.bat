REM Start from a clean build directory
rmdir /Q /S C:\src\TubeTK-Slicer-Release

REM Update the TubeTK Dashboard scripts
cd C:\src\TubeTK-DashboardScripts
"C:\Users\aylward\AppData\Local\Programs\Git\cmd\git" reset --hard HEAD
"C:\Users\aylward\AppData\Local\Programs\Git\cmd\git" pull

IF /i NOT "%~dp0"=="%temp%\" (
  COPY /y "Eden_Kitware_TubeTK_Slicer_Nightly.bat" "%temp%\Eden_Kitware_TubeTK_Slicer_Nightly.bat" >nul
  "%temp%\Eden_Kitware_TubeTK_Slicer_Nightly.bat"
  del "%temp%\Eden_Kitware_TubeTK_Slicer_Nightly.bat"
  exit /B
)

del C:\src\Eden_Kitware_TubeTK_Slicer_Nightly.bat.old
rename C:\src\Eden_Kitware_TubeTK_Slicer_Nightly.bat Eden_Kitware_TubeTK_Slicer_Nightly.bat.old
copy Eden_Kitware_TubeTK_Slicer_Nightly.bat C:\src\Eden_Kitware_TubeTK_Slicer_Nightly.bat
cd ..

REM Run the nightly CTest
"C:\Program Files (x86)\CMake\bin\ctest.exe" -D Nightly -D SITE_CTEST_MODE:STRING=Nightly -D SITE_BUILD_TYPE:STRING=Release -S "C:\src\TubeTK-DashboardScripts\Eden_Kitware_TubeTK_Slicer.cmake" -C Release -V -VV -O "C:\src\Eden_Kitware_TubeTK_Slicer_Nightly.log"

REM Run the continuous CTest
"C:\Program Files (x86)\CMake\bin\ctest.exe" -D Continuous -D SITE_CTEST_MODE:STRING=Continuous -D SITE_BUILD_TYPE:STRING=Release -S "C:\src\TubeTK-DashboardScripts\Eden_Kitware_TubeTK_Slicer.cmake" -C Release -V -VV -O "C:\src\Eden_Kitware_TubeTK_Slicer_Continuous.log"
