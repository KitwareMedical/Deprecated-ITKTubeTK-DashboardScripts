REM Start from a clean build directory
rmdir /Q /S C:\Users\aylward\src\TubeTK-Release

REM Update the TubeTK Dashboard scripts
cd C:\Users\aylward\src\TubeTK-DashboardScripts
"C:\Program Files (x86)\Git\bin\git" reset --hard HEAD
"C:\Program Files (x86)\Git\bin\git" pull
cd ..

REM Run the nightly CTest
"C:\Program Files (x86)\CMake 2.8\bin\ctest.exe" -S "C:\Users\aylward\src\TubeTK-DashboardScripts\Ginger_Aylward_Org_TubeTK.cmake" -O "C:\Users\aylward\src\TubeTK_CDashClient_Nightly_log.txt"
