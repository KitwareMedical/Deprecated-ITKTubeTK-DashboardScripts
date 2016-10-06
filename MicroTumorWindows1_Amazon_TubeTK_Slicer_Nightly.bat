REM Start from a clean build directory
rmdir /Q /S C:\src\dashboards\TubeTK-Slicer-Release

REM Set environment variables
set ITK_BUILD_DIR=C:\src\Slicer-SuperBuild-Release\ITKv4-build
set TubeTK_BUILD_DIR=C:\src\dashboards\TubeTK-Slicer-Release\TubeTK-build

REM Update the TubeTK Dashboard scripts
cd C:\src\dashboards\TubeTK-DashboardScripts
"C:\Program Files\Git\cmd\git" reset --hard HEAD
"C:\Program Files\Git\cmd\git" pull
rename C:\src\dashboards\MicroTumorWindows1_Amazon_TubeTK_Slicer_Nightly.bat C:\src\dashboards\MicroTumorWindows1_Amazon_TubeTK_Slicer_Nightly.bat.old
copy MicroTumorWindows1_Amazon_TubeTK_Slicer_Nightly.bat C:\src\dashboards\MicroTumorWindows1_Amazon_TubeTK_Slicer_Nightly.bat
cd ..

REM Run the nightly CTest
"C:\Program Files\CMake\bin\ctest.exe" -D Nightly -D SITE_CTEST_MODE:STRING=Nightly -D SITE_BUILD_TYPE:STRING=Release -S  "C:\src\dashboards\TubeTK-DashboardScripts\MicroTumorWindows1_Amazon_TubeTK_Slicer.cmake"  -C Release -V -VV -O "C:\src\dashboards\MicroTumorWindows1_Amazon_TubeTK_Slicer_Nightly.log"
