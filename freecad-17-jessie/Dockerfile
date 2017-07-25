#!/bin/bash

# Released under GPL v2.0
# bernd@bimstatik.org
# based on script for vagrant box from FreeCAD source, https://github.com/FreeCAD/FreeCAD/blob/master/vagrant/FreeCAD.sh

# tested on Debian Jessie = 8.0
# username on my vagrant box = vagrant

cd ~             # use if start on a local machine or inside a virtual machine
# cd /home/vagrant   # use with a vagrant box, because cd ~ returns  /root

cd Documents
sudo rm -rf build_FreeCAD
mkdir build_FreeCAD
cd build_FreeCAD
base_dir=`pwd`



package_list="                 doxygen                          \
                               libboost1.55-dev                 \
                               libboost-filesystem1.55-dev      \
                               libboost-program-options1.55-dev \
                               libboost-python1.55-dev          \
                               libboost-regex1.55-dev           \
                               libboost-signals1.55-dev         \
                               libboost-system1.55-dev          \
                               libboost-thread1.55-dev          \
                               libcoin80                        \
                               libcoin80-dev                    \
                               libeigen3-dev                    \
                               libpyside-dev                    \
                               libqtcore4                       \
                               libshiboken-dev                  \
                               libxerces-c-dev                  \
                               libxmu-dev                       \
                               libxmu-headers                   \
                               libxmu6                          \
                               libxmuu-dev                      \
                               libxmuu1                         \
                               pyside-tools                     \
                               python-dev                       \
                               python-pyside                    \
                               python-matplotlib                \
                               qt4-dev-tools                    \
                               qt4-qmake                        \
                               shiboken                         \
                               gmsh                             \
                               swig                             "

sudo apt-get update
sudo apt-get install -y dictionaries-common
sudo apt-get install -y $package_list
sudo apt-get install -y python-pivy
sudo apt-get install -y git
sudo apt-get install -y cmake
sudo apt-get install -y g++
sudo apt-get install -y libfreetype6-dev
# sudo apt-get install -y tcl8.5  # to run DRAWEXE of occt, but it does not run either
sudo apt-get install -y tcl8.5-dev tk8.5-dev
sudo apt-get install -y automake  # netgen
sudo apt-get install -y libtogl-dev
sudo apt-get install -y libhdf5-dev
sudo apt-get install -y libmed
sudo apt-get install -y libmedc
sudo apt-get install -y libmed-dev
sudo apt-get install -y libmedc-dev



# get VTK 7.0.0
cd $base_dir
mkdir vtk
cd vtk
wget http://www.vtk.org/files/release/7.0/VTK-7.0.0.tar.gz
gunzip VTK-7.0.0.tar.gz
tar xf VTK-7.0.0.tar
rm VTK-7.0.0.tar


# get OCCT 7.1.0
cd $base_dir
mkdir occt
cd occt
wget "http://git.dev.opencascade.org/gitweb/?p=occt.git;a=snapshot;h=89aebdea8d6f4d15cfc50e9458cd8e2e25022326;sf=tgz"
mv "index.html?p=occt.git;a=snapshot;h=89aebdea8d6f4d15cfc50e9458cd8e2e25022326;sf=tgz" occt.tgz
gunzip occt.tgz
tar xf occt.tar
rm occt.tar
cd occt-89aebde
grep -v vtkRenderingFreeTypeOpenGL src/TKIVtk/EXTERNLIB >& /tmp/EXTERNLIB
\cp /tmp/EXTERNLIB src/TKIVtk/EXTERNLIB
grep -v vtkRenderingFreeTypeOpenGL src/TKIVtkDraw/EXTERNLIB >& /tmp/EXTERNLIB
\cp /tmp/EXTERNLIB src/TKIVtkDraw/EXTERNLIB


# get Netgenn 5.3.1
cd $base_dir
mkdir netgen
cd netgen
git clone https://github.com/berndhahnebach/Netgen


# get FreeCAD latest Github commit
cd $base_dir
mkdir freecad
cd freecad
git clone https://github.com/FreeCAD/FreeCAD



#  building VTK
cd $base_dir
cd vtk
mkdir build
cd build
cmake ../VTK-7.0.0  -DCMAKE_INSTALL_PREFIX:PATH=/opt/local/FreeCAD-0.17 -DVTK_Group_Rendering:BOOL=OFF -DVTK_Group_StandAlone:BOOL=ON -DVTK_RENDERING_BACKEND=None
make -j 2
sudo make install


# building OCCT
cd $base_dir
cd occt
mkdir build
cd build
cmake ../occt-89aebde  -DCMAKE_INSTALL_PREFIX:PATH=/opt/local/FreeCAD-0.17 -DUSE_VTK:BOOL=OFF
make -j 2
sudo make install


# building Netgen
cd $base_dir
cd netgen
cd Netgen/netgen-5.3.1
./configure --prefix=/opt/local/FreeCAD-0.17  --with-tcl=/usr/lib/tcl8.5  --with-tk=/usr/lib/tk8.5  --enable-occ  --with-occ=/opt/local/FreeCAD-0.17  --enable-shared  --enable-nglib  CXXFLAGS="-DNGLIB_EXPORTS -std=gnu++11"
make -j 2
sudo make install
# copy libsrc, FreeCAD needs it
cd $base_dir
cd netgen
sudo cp -rf Netgen/netgen-5.3.1/libsrc  /opt/local/FreeCAD-0.17/libsrc


# building FreeCAD
cd $base_dir
cd freecad
mkdir build
cd build

# no oce-dev packages, no netgen
# cmake ../FreeCAD -DCMAKE_INSTALL_PREFIX:PATH=/opt/local/FreeCAD-0.17 -DOCC_INCLUDE_DIR=/opt/local/FreeCAD-0.17/include/opencascade

# with oce-dev installed, no netgen
# cmake ../FreeCAD  -DCMAKE_INSTALL_PREFIX:PATH=/opt/local/FreeCAD-0.17  -DFREECAD_USE_OCC_VARIANT="Official Version"  -DOCC_INCLUDE_DIR=/opt/local/FreeCAD-0.17/include/opencascade  -DOCC_LIBRARY=/opt/local/FreeCAD-0.17/lib/libTKernel.so

# no oce-dev packages, with netgen
# cmake ../FreeCAD  -DCMAKE_INSTALL_PREFIX:PATH=/opt/local/FreeCAD-0.17  -DBUILD_FEM_NETGEN=1  -DCMAKE_CXX_FLAGS="-DNETGEN_V5"  -DNETGEN_ROOT=/opt/local/FreeCAD-0.17  -DOCC_INCLUDE_DIR=/opt/local/FreeCAD-0.17/include/opencascade

# with oce-dev installed, with netgen
cmake ../FreeCAD  -DCMAKE_INSTALL_PREFIX:PATH=/opt/local/FreeCAD-0.17  -DBUILD_FEM_NETGEN=1  -DCMAKE_CXX_FLAGS="-DNETGEN_V5"  -DNETGEN_ROOT=/opt/local/FreeCAD-0.17  -DFREECAD_USE_OCC_VARIANT="Official Version"  -DOCC_INCLUDE_DIR=/opt/local/FreeCAD-0.17/include/opencascade  -DOCC_LIBRARY=/opt/local/FreeCAD-0.17/lib/libTKernel.so

make -j 2
sudo make install



# start FreeCAD
# cd ~
# /opt/local/FreeCAD-0.17/bin/FreeCAD 
