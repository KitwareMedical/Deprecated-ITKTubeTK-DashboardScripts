REM Start from a clean build directory
rmdir /Q /S C:\dashboard\src\TubeTK-Release

REM Update the TubeTK Dashboard scripts
cd C:\dashboard\src\TubeTK-DashboardScripts
"C:\Program Files\Git\bin\git" reset --hard HEAD
"C:\Program Files\Git\bin\git" pull
cd ..

REM Run the nightly CTest
"C:\Program Files\CMake 2.8\bin\ctest.exe" -D Nightly -D SITE_CTEST_MODE:STRING=Nightly -D SITE_BUILD_TYPE:STRING=Release -S "C:\dashboard\src\TubeTK-DashboardScripts\Abydos_Kitware_TubeTK.cmake" -C Release -V -VV -O "C:\dashboard\src\Abydos_Kitware_TubeTK_Nightly.log"

REM Run the continuous CTest
"C:\Program Files\CMake 2.8\bin\ctest.exe" -D Continuous -D SITE_CTEST_MODE:STRING=Continuous -D SITE_BUILD_TYPE:STRING=Release -S "C:\dashboard\src\TubeTK-DashboardScripts\Abydos_Kitware_TubeTK.cmake" -C Release -V -VV -O "C:\dashboard\src\Abydos_Kitware_TubeTK_Continuous.log"
