#!/bin/sh

MachineName=Deathstar_Kitware

echo "Running TubeTK Dashboard script"
if [ $# -eq 0 ] || [ "$1" != "NoUpdate" ]; then

  echo "Updating"
  rm -rf /home/matt/dashboards/TubeTK-RelWithDebInfo

  # Update Dashboard repository
  cd /home/matt/dashboards/TubeTK-DashboardScripts
  git pull

  echo "Bootstrapping"
  # Get new nightly script
  cp -f ${MachineName}_TubeTK_Nightly.sh ..
  cd ..
  chmod +x ${MachineName}_TubeTK_Nightly.sh

  # Run new nightly script without updating again
  ./${MachineName}_TubeTK_Nightly.sh NoUpdate

else

  # Run the nightly
  /usr/local/bin/ctest -D Nightly -D SITE_CTEST_MODE:STRING=Nightly -D SITE_BUILD_TYPE:STRING=RelWithDebInfo -S TubeTK-DashboardScripts/${MachineName}_TubeTK.cmake -V -VV -O ${MachineName}_TubeTK_Nightly.log

fi

echo "Ending TubeTK Dashboard script"
