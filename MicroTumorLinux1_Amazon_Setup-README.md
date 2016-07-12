To install a new dashboard on Ubuntu 14.04, run the following commands:

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

Install Slicer - To compile TubeTK with Slicer

```
cd ~/src                                         && \
git clone https://github.com/Slicer/Slicer.git   && \
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

18 4 * * * /home/ubuntu/src/dashboards/MicroTumorLinux1_Amazon_TubeTK_Nightly-Debug.sh
19 5 * * * /home/ubuntu/src/dashboards/MicroTumorLinux1_Amazon_TubeTK_Nightly-Release.sh
18 6 * * * /home/ubuntu/src/dashboards/MicroTumorLinux1_Amazon_TubeTK_Slicer_Nightly.sh


To install a new dashboard on Windows Server 2012, run the following commands:

Download Visual Studio Community 2015:
https://www.visualstudio.com/post-download-vs?sku=community&clcid=0x409&downloadrename=true

In Powershell:
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco install -y git cmder vim processhacker cmake ninja python3 python2
mkdir src
cd src
git clone https://github.com/Slicer/Slicer.git
Download https://sliksvn.com/download/
Download Qt 4.8.7
http://download.qt.io/official_releases/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.zip


