#!/bin/sh

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ubuntu/Support/qt-easy-build/qt-everywhere-opensource-build-4.8.7/lib 
export ITK_BUILD_DIR=$HOME/build/ITK-build
export TubeTK_BUILD_DIR=$HOME/itktubetk-external-itk-vtk/build

MachineName=Amazon_Hastings
BuildType=Release
CTestCommand=/usr/bin/ctest
DashboardDir=/home/ubuntu/src/dashboards

echo "Running ITKTubeTK Dashboard script"
if [ $# -eq 0 ] || [ "$1" != "NoUpdate" ]; then

  echo "Updating"
  rm -rf ${DashboardDir}/ITKTubeTK-Build-${BuildType}

  # Update Dashboard repository
  cd ${DashboardDir}/ITKTubeTK-DashboardScripts
  git pull -f

  echo "Bootstrapping"
  # Get new nightly script
  cp -f ${MachineName}_TubeTK_Nightly.sh ..
  cd ..
  chmod +x ${MachineName}_TubeTK_Nightly.sh

  # Run new nightly script without updating again
  ./${MachineName}_TubeTK_Nightly.sh NoUpdate

else

# Run the nightly
echo "Running nightly ctest"
${CTestCommand} -D Nightly -D SITE_CTEST_MODE:STRING=Nightly -D SITE_BUILD_TYPE:STRING=${BuildType} -S ITKTubeTK-DashboardScripts/${MachineName}_TubeTK.cmake -V -VV -O ${MachineName}_TubeTK_Nightly.log

echo "Running continuous ctest"
${CTestCommand} -D Continuous -D SITE_CTEST_MODE:STRING=Continuous -D SITE_BUILD_TYPE:STRING=${BuildType} -S ITKTubeTK-DashboardScripts/${MachineName}_TubeTK.cmake -V -VV -O ${MachineName}_TubeTK_Continuous.log

fi

echo "Ending ITKTubeTK dashboard script"
