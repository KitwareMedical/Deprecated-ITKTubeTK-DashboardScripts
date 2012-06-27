#!/bin/sh

MachineName=Mojo_Kitware

if [ $# -eq 0 ] || [ "$1" != "NoUpdate" ]; then
  # Update itself
  echo "Updating"
  rm -rf /home/aylward/src/TubeTK-Release
 
  # Update Dashboard repository
  cd /home/aylward/src/TubeTK_Dashboards
  git pull -f
 
  # Get new nightly script
  cp -f ${MachineName}_TubeTK_Nightly.sh ..
  cd ..
  chmod +x ${MachineName}_TubeTK_Nightly.sh
  
  # Run new nightly script without updating again
  ./${MachineName}_TubeTK_Nightly.sh NoUpdate
fi

# Run the nightly
/usr/local/bin/ctest -S TubeTK_Dashboards/${MachineName}_TubeTK_Nightly.cmake -V -VV -O ${MachineName}_TubeTK_Nightly.log

# Run the continuous
/usr/local/bin/ctest -S TubeTK_Dashboards/${MachineName}_TubeTK_Continuous.cmake -V -VV -O ${MachineName}_TubeTK_Continuous.log
