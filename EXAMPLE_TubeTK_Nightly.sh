#!/bin/sh

MachineName=Krull_Kitware
BuildType=Release
CTestCommand=/usr/local/bin/ctest

echo "Removing old build"
rm -rf TubeTK-${BuildType}
 
echo "Updating"
cd TubeTK_Dashboards
git pull
cd ..
 
# Run the nightly
echo "Running nightly ctest"
${CTestCommand} -S TubeTK_Dashboards/${MachineName}_TubeTK_Nightly.cmake -V -VV -O ${MachineName}_TubeTK_Nightly.log

echo "Running continuous ctest"
${CTestCommand} -S TubeTK_Dashboards/${MachineName}_TubeTK_Continuous -V -VV -O ${MachineName}_TubeTK_Continuous.log
