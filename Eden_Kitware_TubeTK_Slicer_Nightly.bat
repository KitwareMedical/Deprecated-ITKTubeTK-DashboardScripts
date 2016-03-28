REM Start from a clean build directory
rmdir /Q /S C:\src\TubeTK-Slicer-Release

REM Update the TubeTK Dashboard scripts
cd C:\src\TubeTK-DashboardScripts
"C:\Users\aylward\AppData\Local\Programs\Git\cmd\git" reset --hard HEAD
"C:\Users\aylward\AppData\Local\Programs\Git\cmd\git" pull
rename C:\src\Eden_Kitware_TubeTK_Slicer_Nightly.bat C:\src\Eden_Kitware_TubeTK_Slicer_Nightly.bat.old
copy Eden_Kitware_TubeTK_Slicer_Nightly.bat C:\src\Eden_Kitware_TubeTK_Slicer_Nightly.bat
cd ..

REM Run the nightly CTest
"C:\Program Files (x86)\CMake\bin\ctest.exe" -D Nightly -D SITE_CTEST_MODE:STRING=Nightly -D SITE_BUILD_TYPE:STRING=Release -S "C:\src\TubeTK-DashboardScripts\Eden_Kitware_TubeTK_Slicer.cmake" -C Release -V -VV -O "C:\src\Eden_Kitware_TubeTK_Slicer_Nightly.log"

REM Run the continuous CTest
"C:\Program Files (x86)\CMake\bin\ctest.exe" -D Continuous -D SITE_CTEST_MODE:STRING=Continuous -D SITE_BUILD_TYPE:STRING=Release -S "C:\src\TubeTK-DashboardScripts\Eden_Kitware_TubeTK_Slicer.cmake" -C Release -V -VV -O "C:\src\Eden_Kitware_TubeTK_Slicer_Continuous.log"
