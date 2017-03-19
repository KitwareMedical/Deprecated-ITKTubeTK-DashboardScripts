#!/bin/sh

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/Users/aylward/src/Qt/lib
export ITK_BUILD_DIR=$HOME/src/ITKTubeTK-Build-Debug/ITK-build
export TubeTK_BUILD_DIR=$HOME/src/ITKTubeTK-Build-Debug/TubeTK-build

MachineName=Eden_Aylward
BuildType=Release
CTestCommand=/Applications/CMake.app/Contents/bin/ctest
DashboardDir=/Users/aylward/src

echo "Running ITKTubeTK Dashboard script"
if [ $# -eq 0 ] || [ "$1" != "NoUpdate" ]; then

  echo "Updating"
  rm -rf ${DashboardDir}/ITKTubeTK-Slicer-Build-${BuildType}

  # Update Dashboard repository
  cd ${DashboardDir}/ITKTubeTK-DashboardScripts
  git pull -f

  echo "Bootstrapping"
  # Get new nightly script
  cp -f ${MachineName}_TubeTK_Slicer_Nightly.sh ..
  cd ..
  chmod +x ${MachineName}_TubeTK_Slicer_Nightly.sh

  # Run new nightly script without updating again
  ./${MachineName}_TubeTK_Slicer_Nightly.sh NoUpdate

else

# Run the nightly
echo "Running nightly ctest"
${CTestCommand} -D Nightly -D SITE_CTEST_MODE:STRING=Nightly -D SITE_BUILD_TYPE:STRING=${BuildType} -S ITKTubeTK-DashboardScripts/${MachineName}_TubeTK_Slicer.cmake -V -VV -O ${MachineName}_TubeTK_Slicer_Nightly.log

echo "Running continuous ctest"
${CTestCommand} -D Continuous -D SITE_CTEST_MODE:STRING=Continuous -D SITE_BUILD_TYPE:STRING=${BuildType} -S ITKTubeTK-DashboardScripts/${MachineName}_TubeTK_Slicer.cmake -V -VV -O ${MachineName}_TubeTK_Slicer_Continuous.log

fi

echo "Ending ITKTubeTK dashboard script"
