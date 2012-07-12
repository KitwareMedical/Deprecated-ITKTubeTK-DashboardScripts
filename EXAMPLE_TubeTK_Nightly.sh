#!/bin/sh

MachineName=Krull_Kitware
BuildType=Release
CTestCommand=/usr/local/bin/ctest
DashboardDir=/home/aylward/src/dashboards

cd ${DashboardDir}

echo "Removing old build"
rm -rf TubeTK-${BuildType}
 
echo "Updating"
cd TubeTK_Dashboards
git pull -f
cd ..
 
# Run the nightly
echo "Running nightly ctest"
${CTestCommand} -S TubeTK_Dashboards/${MachineName}_TubeTK_Nightly.cmake -V -VV -O ${MachineName}_TubeTK_Nightly.log

echo "Running continuous ctest"
${CTestCommand} -S TubeTK_Dashboards/${MachineName}_TubeTK_Continuous -V -VV -O ${MachineName}_TubeTK_Continuous.log
