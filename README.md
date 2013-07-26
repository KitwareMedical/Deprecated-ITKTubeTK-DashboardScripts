TubeTK Dashboard Scripts
========================

This is a directory of the files that control TubeTK's dashboard machines. These files are updated and run on the dashboard client machines every night.

Assumptions
-----------

1. The top level of your dashboard directory is `/home/me/src/dashboards`.
2. The machine's name is `MyMachine`.

Commands
--------

Go to the top level of your dashboard clients.

    $ cd /home/me/src/dashboards

Get a copy of all the dashboard scripts from the Git repository, including some example scripts.

    $ git clone -b dashboard http://tubetk.org/TubeTK.git TubeTK_Dashboards

This is the script that will update and launch your dashboard client every night. Use the `.bat` file if you are doing this on Microsoft Windows.
  
    $ cp TubeTK_Dashboards/EXAMPLE_TubeTK_Nightly.sh TubeTK_Nightly.sh

Setup your machine's parameters as described in the file.

    $ vi TubeTK_Nightly.sh

Create a specific set of parameters for your dashboard machine.

    $ cd TubeTK_Dashboards
    $ cp EXAMPLE_Linux.cmake MyMachine_TubeTK_Nightly.cmake

Setup the parameters as specified in that file.

    $ vi MyMachine_TubeTK_Nightly.cmake

By adding your script to the Git repository, your dashboard machine can be updated without having to log into it.

    $ git add MyMachine_TubeTK_Nightly.cmake
    $ git commit -m "ENH: Initial setup for MyMachine"

Make sure you have the latest copy of the `TubeTK_Dashboard` directory and then submit your changes to the Git repository.

    $ git pull
    $ git push

Do this on Linux machines to setup a recurring nightly job.

    $ crontab -e
   
Add the following line, but please change the start minute (20) and the start hour (0) to different values to avoid simultaneous downloads from multiple machines.

    20 0 * * * /home/me/src/dashboards/TubeTK_Nightly.sh

On Microsoft Windows, use the task scheduler to run your `TubeTK_Nightly.bat` script.

---
*This file is part of [TubeTK](http://www.tubetk.org). TubeTK is developed by [Kitware, Inc.](http://www.kitware.com) and licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).*
