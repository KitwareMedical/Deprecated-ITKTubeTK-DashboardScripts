#!/bin/sh

export ITK_BUILD_DIR=${HOME}/src/ITK-Debug
export TubeTK_BUILD_DIR=${HOME}/src/ITKTubeTK-Debug/TubeTK-build

export QT_SELECT=qt5

export ExternalData_OBJECT_STORES=${HOME}/src/ExternalData

MachineName=Mountain_Aylward
BuildType=Debug
CTestCommand=/usr/bin/ctest
DashboardDir=${HOME}/src/

echo "Running ITKTubeTK Debug Dashboard script"
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

#echo "Running continuous ctest"
#${CTestCommand} -D Continuous -D SITE_CTEST_MODE:STRING=Continuous -D SITE_BUILD_TYPE:STRING=${BuildType} -S ITKTubeTK-DashboardScripts/${MachineName}_TubeTK.cmake -V -VV -O ${MachineName}_TubeTK_Continuous-${BuildType}.log

fi

echo "Ending ITKTubeTK Debug Dashboard script"
