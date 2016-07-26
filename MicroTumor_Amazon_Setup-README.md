To install a new dashboard on Ubuntu 14.04, run the following commands:
=======================================================================

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install git make gcc g++ libncurses5-dev subversion libssl-dev libx11-dev libxt-dev libgl1-mesa-dev libosmesa6-dev libglu1-mesa-dev libfontconfig-dev libxrender-dev ninja-build -y
sudo apt-get install python-numpy python-scipy python-pip -y
sudo apt-get install libhdf5-dev -y # required by 'tables'
sudo pip install IPython tornado zmq jinja2 tables matplotlib
```

Install cmake

```
mkdir ~/Support                                         && \
cd ~/Support                                            && \
wget http://www.cmake.org/files/v3.5/cmake-3.5.0.tar.gz && \
tar xzvf cmake-3.5.0.tar.gz                             && \
cd cmake-3.5.0                                          && \
./configure                                             && \
make -j4                                                && \
cd ..                                                   && \
mv cmake-3.5.0 cmake-3.5.0-nossl                        && \
tar -xvzf cmake-3.5.0.tar.gz                            && \
mkdir cmake-3.5.0-build                                 && \
cd cmake-3.5.0-build/                                   && \
../cmake-3.5.0-nossl/bin/cmake -DCMAKE_USE_OPENSSL:BOOL=ON \
-DCMAKE_USE_OPENSSL:BOOL=ON -DCMAKE_BUILD_TYPE:STRING=Release ../cmake-3.5.0 && \
make -j4                                                && \
sudo make install
```

Install Qt4.8.7

```
cd ~/Support                                         && \
git clone https://github.com/jcfr/qt-easy-build.git  && \
cd qt-easy-build                                     && \
sudo ./Build-qt.sh
```

Install PySide - required for pyqtgraph

```
sudo pip install PySide --install-option "--qmake=/usr/local/Trolltech/Qt-4.8.7/bin/qmake"
```

Install pyqtgraph

```
sudo pip install pyqtgraph
```

Install Slicer - To compile TubeTK with Slicer (Get Slicer revision from TubeTK/CMake/CircleCI/CircleCI_slicer_Docker/Dockerfile)

```
cd ~/src                                         && \
git clone https://github.com/Slicer/Slicer.git   && \
cd Slicer                                        && \
git checkout {TubeTK_hash}                       && \
cd ..                                            && \
mkdir Slicer-SuperBuild-Release                  && \
cd mkdir Slicer-SuperBuild-Release               && \
cmake -DCMAKE_BUILD_TYPE:STRING=Release -DQT_QMAKE_EXECUTABLE:FILEPATH=/usr/local/Trolltech/Qt-4.8.7/bin/qmake ../Slicer                                           && \
make -j 8
```

Download and install dashboard scripts

See [README.md](https://github.com/KitwareMedical/TubeTK-DashboardScripts/blob/master/README.md)

Amazon computers have UTC time: +4 EST -> 12am EST -> 4am UTC
Add the following lines to cron:
```
crontab -e
```

```
18 4 * * * /home/ubuntu/src/dashboards/MicroTumorLinux1_Amazon_TubeTK_Nightly-Debug.sh
19 5 * * * /home/ubuntu/src/dashboards/MicroTumorLinux1_Amazon_TubeTK_Nightly-Release.sh
18 6 * * * /home/ubuntu/src/dashboards/MicroTumorLinux1_Amazon_TubeTK_Slicer_Nightly.sh
```


To install a new dashboard on Windows Server 2012, run the following commands:
==============================================================================

Download [Visual Studio Express 2013](https://www.microsoft.com/en-us/download/details.aspx?id=44914)

In Powershell (run as administrator):
```
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco install -y git cmake ninja python2
cd c:\
```

Download [SVN](https://sliksvn.com/download/)

Build Qt:

```
mkdir src
cd src
```
Run `vcvars64.bat` in Visual Studio / VC / amd64 directory
Run qt-easy-build powershell script (see):

```
@powershell -Command "$destDir='C:\src';$buildType='Release';$qtPlatform='win32-msvc2013';$bits='64';iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/jcfr/qt-easy-build/4.8.7/windows_build_qt.ps1'))"
```

Install python libraries from [here](http://www.lfd.uci.edu/~gohlke/pythonlibs/)
Open Command line as administrator:
```
cd c:\tools\python2\Scripts
pip install --upgrade pip
```

[Download requirement (Microsoft Visual C++ 2008 Redistributable Package (x86) )](https://www.microsoft.com/en-us/download/details.aspx?id=29)

Download packages wheel file and install, starting with numpy:
```
pip install [path to downloaded wheel .whl]
```

* numpy-1.11.1+mkl-cp27-cp27m-win_amd64.whl
* scipy-0.17.1-cp27-cp27m-win_amd64.whl
* tornado-4.4.1-cp27-cp27m-win_amd64.whl
* Jinja2-2.8-py2.py3-none-any.whl
* jsonschema-2.5.1-py2.py3-none-any.whl
* pyzmq-15.3.0-cp27-cp27m-win_amd64.whl
* numexpr-2.6.1-cp27-cp27m-win_amd64.whl
* tables-3.2.3-cp27-cp27m-win_amd64.whl
* matplotlib-1.5.2-cp27-cp27m-win_amd64.whl
* ipython-3.2.3-py27-none-any.whl
* PySide-1.2.2-cp27-none-win_amd64.whl
* pyqtgraph-0.9.10-py2.py3-none-any.whl

Download Slicer:

```
git clone https://github.com/Slicer/Slicer.git
```

Get Slicer revision from TubeTK/CMake/CircleCI/CircleCI_slicer_Docker/Dockerfile. Configure and compile Slicer.

Download TubeTK dashboard scripts:

```
mkdir c:\src\dashboards
cd c:\src\dashboards
git clone https://github.com/KitwareMedical/TubeTK-DashboardScripts.git
```
