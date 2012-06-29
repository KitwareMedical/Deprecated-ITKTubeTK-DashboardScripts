#!/bin/sh

MachineName=Dash21_Kitware

if [ $# -eq 0 ] || [ "$1" != "NoUpdate" ]; then
  echo "Updating"
  rm -rf /home/kitware/Dashboards/TubeTK-Debug

  # Update Dashboard repository
  cd /home/kitware/Dashboards/TubeTK_Dashboards
  git pull -f

  # Get new nightly script
  cp -f ${MachineName}_TubeTK_Nightly.sh ..
  cd ..
  chmod +x ${MachineName}_TubeTK_Nightly.sh
  
  # Run new nightly script without updating again
  ./${MachineName}_TubeTK_Nightly.sh NoUpdate

else

  # Run the nightly
  /home/kitware/Dashboards/Support/cmake-2.8.8/bin/ctest -S TubeTK_Dashboards/${MachineName}_TubeTK_Nightly.cmake -V -VV -O ${MachineName}_TubeTK_Nightly.log

fi
