#!/bin/sh

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/Trolltech/Qt-4.8.7/lib
export ITK_BUILD_DIR=$HOME/src/Slicer-SuperBuild-Release/ITKv4-build
export TubeTK_BUILD_DIR=$HOME/src/dashboards/TubeTK-Slicer-Release-build/TubeTK-build

MachineName=MicroTumorLinux1_Amazon
BuildType=Release
CTestCommand=/usr/local/bin/ctest
DashboardDir=/home/ubuntu/src/dashboards

echo "Running TubeTK_Slicer Dashboard script"
if [ $# -eq 0 ] || [ "$1" != "NoUpdate" ]; then

  echo "Updating"
  rm -rf ${DashboardDir}/TubeTK-Slicer-${BuildType}-build

  # Update Dashboard repository
  cd ${DashboardDir}/TubeTK-DashboardScripts
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
${CTestCommand} -D Nightly -D SITE_CTEST_MODE:STRING=Nightly -D SITE_BUILD_TYPE:STRING=${BuildType} -S TubeTK-DashboardScripts/${MachineName}_TubeTK_Slicer.cmake -V -VV -O ${MachineName}_TubeTK_Slicer_Nightly.log

echo "Running continuous ctest"
${CTestCommand} -D Continuous -D SITE_CTEST_MODE:STRING=Continuous -D SITE_BUILD_TYPE:STRING=${BuildType} -S TubeTK-DashboardScripts/${MachineName}_TubeTK_Slicer.cmake -V -VV -O ${MachineName}_TubeTK_Slicer_Continuous.log

fi

echo "Ending TubeTK dashboard script"
