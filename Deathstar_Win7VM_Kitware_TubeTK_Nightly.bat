REM Start from a clean build directory
rmdir /Q /S C:\Dashboards\TubeTK\TubeTK-Release

REM Update the TubeTK Dashboard scripts
cd C:\Dashboards\TubeTK\TubeTK-DashboardScripts
REM "C:\Program Files (x86)\Git\bin\git" reset --hard HEAD
"C:\Program Files (x86)\Git\bin\git" pull
cd ..

REM Run the nightly CTest
"C:\Program Files (x86)\CMake 2.8\bin\ctest.exe" -S "C:\Dashboards\TubeTK\TubeTK-DashboardScripts\Deathstar_Win7VM_Kitware_TubeTK.cmake" -O "C:\Dashboards\TubeTK\TubeTK_CDashClient_Nightly_log.txt"
