REM Start from a clean build directory
rmdir /Q /S C:\src\TubeTK-Release

cd C:\src\TubeTK-DashboardScripts

REM Update the TubeTK Dashboard scripts
SETLOCAL
IF /i NOT "%~dp0"=="%temp%\" (
  "C:\Users\aylward\AppData\Local\Programs\Git\cmd\git" reset --hard HEAD
  "C:\Users\aylward\AppData\Local\Programs\Git\cmd\git" pull
  COPY /y "Eden_Kitware_TubeTK_Nightly.bat" "%temp%\Eden_Kitware_TubeTK_Nightly.bat" >nul
  "%temp%\Eden_Kitware_TubeTK_Nightly.bat"
  del "%temp%\Eden_Kitware_TubeTK_Nightly.bat"
  exit /B
)
ENDLOCAL

del C:\src\Eden_Kitware_TubeTK_Nightly.bat.old
rename C:\src\Eden_Kitware_TubeTK_Nightly.bat Eden_Kitware_TubeTK_Nightly.bat.old
copy Eden_Kitware_TubeTK_Nightly.bat C:\src\Eden_Kitware_TubeTK_Nightly.bat
cd ..

REM Run the nightly CTest
"C:\Program Files (x86)\CMake\bin\ctest.exe" -D Nightly -D SITE_CTEST_MODE:STRING=Nightly -D SITE_BUILD_TYPE:STRING=Release -S "C:\src\TubeTK-DashboardScripts\Eden_Kitware_TubeTK.cmake" -C Release -V -VV -O "C:\src\Eden_Kitware_TubeTK_Nightly.log"

REM Run the continuous CTest
"C:\Program Files (x86)\CMake\bin\ctest.exe" -D Continuous -D SITE_CTEST_MODE:STRING=Continuous -D SITE_BUILD_TYPE:STRING=Release -S "C:\src\TubeTK-DashboardScripts\Eden_Kitware_TubeTK.cmake" -C Release -V -VV -O "C:\src\Eden_Kitware_TubeTK_Continuous.log"
