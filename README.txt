This is a directory of the files that control TubeTK's dashboard machines.
These files are updated and run on the dashboard client machines every night.

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
 $ cd ~/src/dashboards
    # Go to the top level of your dashboard clients

 $ git clone -b dashboard http://tubetk.org/TubeTK.git TubeTK_Dashboards
    # Get a copy of all dashboard scripts, include some example scripts

 $ cp TubeTK_Dashboards/EXAMPLE_TubeTK_Nightly.sh TubeTK_Nightly.sh
    # This is the script which will update and launch your dashboard client
    # every night.   
    # Use the .bat file if you are doing this on Windows

 $ vi TubeTK_Nightly.sh
    # Setup your machine's parameters as described in the file

 $ cd TubeTK_Dashboards
 $ cp EXMPLE_Linux.cmake MyMachine_TubeTK_Nightly.cmake
    # Create a specific set of parameters for your dashboard machine

 $ vi MyMachine_TubeTK_Nightly.cmake
    # Setup the parameters as specified in that file

 $ git add MyMachine_TubeTK_Nightly.cmake
 $ git commit -m "ENH: Initial setup for MyMachine"
     # By adding your script to the repo, your dashboard machine can be
     # updated without having to log into it.

 $ git pull
 $ git push
     # Make sure you have the latest copy of the TubeTK_Dashboard directory
     # and then submit your changes to the git repo

 $ crontab -e
    # Do this on Linux machines to setup a recurrent nightly job.
    # Add the following line, but please change the start minute (20) 
    # and the start hour (0) to different values to avoid simulataneous
    # downloads from multiple machines.
    20 0 * * * /home/me/src/dashboards/TubeTK_Nightly.sh

    # On Windows, use the task scheduler to run your TubeTK_Nightly.bat
    # script.
