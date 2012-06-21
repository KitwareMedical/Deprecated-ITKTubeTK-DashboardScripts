#! /bin/sh
cd /home/aylward/src/dashboards
/usr/local/bin/ctest -S TubeTK_Dashboards/Eternia_Kitware_TubeTK_Nightly.cmake -D Nightly -V -VV -O Eternia_Kitware_TubeTK_Nightly.log
