#! /bin/sh

MachineName=Eternia_Kitware

if [ $1 != NoUpdate ]; then
  echo "Updating"
  # Update Dashboard repository
  cd /home/aylward/src/dashboards/TubeTK_Dashboards
  git pull -f

  # Get new nightly script
  cp -f ${MachineName}_TubeTK_Nightly.sh ..
  cd ..
  chmod +x ${MachineName}_TubeTK_Nightly.sh
  
  # Run new nightly script without updating again
  ./${MachineName}_TubeTK_Nightly.sh NoUpdate
fi

# Run the nightly
/usr/local/bin/ctest -S TubeTK_Dashboards/${MachineName}_TubeTK_Nightly.cmake -D Nightly -V -VV -O ${machineName}_TubeTK_Nightly.log
