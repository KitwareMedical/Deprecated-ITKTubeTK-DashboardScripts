#!/bin/sh

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/Users/aylward/src/Qt/lib
export ITK_BUILD_DIR=$HOME/src/TubeTK-Debug-Build/ITK-build
export TubeTK_BUILD_DIR=$HOME/src/TubeTK-Debug-Build/TubeTK-build

MachineName=Eden_Aylward
BuildType=Release
CTestCommand=/Applications/CMake.app/Contents/bin/ctest
DashboardDir=/Users/aylward/src

echo "Running TubeTK Dashboard script"
if [ $# -eq 0 ] || [ "$1" != "NoUpdate" ]; then

  echo "Updating"
  rm -rf ${DashboardDir}/TubeTK-${BuildType}-Build

  # Update Dashboard repository
  cd ${DashboardDir}/TubeTK-DashboardScripts
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
${CTestCommand} -D Nightly -D SITE_CTEST_MODE:STRING=Nightly -D SITE_BUILD_TYPE:STRING=${BuildType} -S TubeTK-DashboardScripts/${MachineName}_TubeTK.cmake -V -VV -O ${MachineName}_TubeTK_Nightly.log

echo "Running continuous ctest"
${CTestCommand} -D Continuous -D SITE_CTEST_MODE:STRING=Continuous -D SITE_BUILD_TYPE:STRING=${BuildType} -S TubeTK-DashboardScripts/${MachineName}_TubeTK.cmake -V -VV -O ${MachineName}_TubeTK_Continuous.log

fi

echo "Ending TubeTK dashboard script"
