#!/bin/sh

export ITK_BUILD_DIR=$HOME/src/ITK-Release
export TubeTK_BUILD_DIR=$HOME/src/ITKTubeTK-Release/TubeTK-build

MachineName=Mountain_Aylward
BuildType=Release
CTestCommand=/usr/bin/ctest
DashboardDir=/home/aylward/src/

echo "Running ITKTubeTK Dashboard script"
if [ $# -eq 0 ] || [ "$1" != "NoUpdate" ]; then

  echo "Updating"
  rm -rf ${DashboardDir}/ITKTubeTK-${BuildType}

  # Update Dashboard repository
  cd ${DashboardDir}/ITKTubeTK-DashboardScripts
  git pull -f

  echo "Bootstrapping"
  # Get new nightly script
  cp -f ${MachineName}_TubeTK_Nightly-${BuildType}.sh ..
  cd ..
  chmod +x ${MachineName}_TubeTK_Nightly-${BuildType}.sh

  # Run new nightly script without updating again
  ./${MachineName}_TubeTK_Nightly-${BuildType}.sh NoUpdate

else

# Run the nightly
echo "Running nightly ctest"
${CTestCommand} -D Nightly -D SITE_CTEST_MODE:STRING=Nightly -D SITE_BUILD_TYPE:STRING=${BuildType} -S ITKTubeTK-DashboardScripts/${MachineName}_TubeTK.cmake -V -VV -O ${MachineName}_TubeTK_Nightly-${BuildType}.log

echo "Running continuous ctest"
${CTestCommand} -D Continuous -D SITE_CTEST_MODE:STRING=Continuous -D SITE_BUILD_TYPE:STRING=${BuildType} -S ITKTubeTK-DashboardScripts/${MachineName}_TubeTK.cmake -V -VV -O ${MachineName}_TubeTK_Continuous-${BuildType}.log

fi

echo "Ending ITKTubeTK ${BuildType} dashboard script"
