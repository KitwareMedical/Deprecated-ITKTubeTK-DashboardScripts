This is a directory of the files that control our dashboard machines.  These 
files are updated and run on the dashboard machines every night.

Creating a new dashboard machine
================================

Assumptions: 
------------
1) The top level of your dashboard directory is
  ~/src/dashboards
2) The machine's name is 
  MyMachine

Commands:
---------
cd ~/src/dashboards
git clone -b dashboard http://tubetk.org/TubeTK.git TubeTK_Dashboards
cp TubeTK_Dashboards/EXAMPLE_Linux.sh MyMachine_TubeTK_Nightly.sh
vi MyMachine_TubeTK_Nightly.sh
  # Setup the parameters as specified in that file
cp MyMachine_TubeTK_Nightly.sh TubeTK_Dashboards
cd TubeTK_Dashboards
cp EXMPLE_Linux.cmake MyMachine_TubeTK_Nightly.cmake
vi MyMachine_TubeTK_Nightly.cmake
  # Setup the parameters as specified in that file
git add MyMachine_TubeTK_Nightly.sh MyMachine_TubeTK_Nightly.cmake
git commit
  # Message = ENH: Initial setup for MyMachine
git push
crontab -e
  # Add the line
  20 0 * * * /home/me/src/dashboards/MyMachine_TubeTK_Nightly.sh
