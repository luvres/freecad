FROM debian:jessie
MAINTAINER Leonardo Loures <luvres@hotmail.com>

# Released under GPL v2.0
# bernd@bimstatik.org
# based on script for vagrant box from FreeCAD source, https://github.com/FreeCAD/FreeCAD/blob/master/vagrant/FreeCAD.sh

# tested on Debian Jessie = 8.0
# username on my vagrant box = vagrant

ENV FREECAD=/opt/local/FreeCAD-0.17
RUN \
    cd \
    && mkdir -p $FREECAD \
#    && rm -rf build_FreeCAD
#    && mkdir build_FreeCAD
#    && cd build_FreeCAD
#    && base_dir=`pwd`
    \
    && package_list=" doxygen \
                      libboost1.55-dev \
                      libboost-filesystem1.55-dev \
                      libboost-program-options1.55-dev \
                      libboost-python1.55-dev \
                      libboost-regex1.55-dev \
                      libboost-signals1.55-dev \
                      libboost-system1.55-dev \
                      libboost-thread1.55-dev \
                      libcoin80 \
                      libcoin80-dev \
                      libeigen3-dev \
                      libpyside-dev \
                      libqtcore4 \
                      libshiboken-dev \
                      libxerces-c-dev \
                      libxmu-dev \
                      libxmu-headers \
                      libxmu6 \
                      libxmuu-dev \
                      libxmuu1 \
                      pyside-tools \
                      python-dev \
                      python-pyside \
                      python-matplotlib \
                      qt4-dev-tools \
                      qt4-qmake \
                      shiboken \
                      gmsh \
                      swig " \
    \
    && apt-get update \
    && apt-get install -y \
        dictionaries-common wget \
        $package_list \
        python-pivy \
        git \
        cmake \
        g++ \
        libfreetype6-dev \
        tcl8.5-dev \
        tk8.5-dev \
        automake \
        libtogl-dev \
        libhdf5-dev \
        #libmed
        #libmedc
        libmed-dev \
        libmedc-dev

### get VTK 7.0.0
#-----------------
# 7.0 - 7.0.0
# 7.1 - 7.1.1
# 8.0 - 8.0.0
RUN \
    vtk_VERSION_MAJOR=7.0 && \
    vtk_VERSION_MINOR=7.0.0 && \
  \
    cd \
    && mkdir vtk \
    && cd vtk \
    && wget http://www.vtk.org/files/release/${vtk_VERSION_MAJOR}/VTK-${vtk_VERSION_MINOR}.tar.gz \
    && gunzip VTK-${vtk_VERSION_MINOR}.tar.gz \
    && tar xf VTK-${vtk_VERSION_MINOR}.tar \
    && rm VTK-${vtk_VERSION_MINOR}.tar \
  # building VTK
    && mkdir build \
    && cd build \
  \
    && cmake ../VTK-${vtk_VERSION_MINOR} \
            -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
            -DVTK_Group_Rendering:BOOL=OFF \
            -DVTK_Group_StandAlone:BOOL=ON \
            -DVTK_RENDERING_BACKEND=None \
  \
    && make -j$(nproc) \
    && make install

### get OCCT 7.1.0
#------------------
RUN \
    #url_OCCT="http://git.dev.opencascade.org/gitweb/?p=occt.git;a=snapshot;h=89aebdea8d6f4d15cfc50e9458cd8e2e25022326;sf=tgz" && 
    url_OCCT="http://desktop/Workstation/occt-7.1.0.tgz" && \
    dir_OCCT=89aebde && \
  \  
    cd \
    && mkdir occt \
    && cd occt \
  \
    && wget ${url_OCCT} -O occt.tgz \
    && gunzip occt.tgz \
    && tar xf occt.tar \
    && rm occt.tar \
    && cd occt-${dir_OCCT} \
  \
    && bash -c "grep -v vtkRenderingFreeTypeOpenGL src/TKIVtk/EXTERNLIB >& /tmp/EXTERNLIB" \
    && cp /tmp/EXTERNLIB src/TKIVtk/EXTERNLIB \
    && bash -c "grep -v vtkRenderingFreeTypeOpenGL src/TKIVtkDraw/EXTERNLIB >& /tmp/EXTERNLIB" \
    && cp /tmp/EXTERNLIB src/TKIVtkDraw/EXTERNLIB \
  # building OCCT
    && cd .. \
    && mkdir build \
    && cd build \
  \
    && cmake \
        ../occt-${dir_OCCT} \
        -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
        -DUSE_VTK:BOOL=OFF \
  \
    && make -j$(nproc) \
    && make install
    
### get Netgen 5.3.1
#--------------------
RUN \
    cd \
    && apt-get install -y \
    openmpi-bin libopenmpi-dev \
    && git clone https://github.com/luvres/netgen.git \
    && cd netgen \
  \
  # building Netgen
    && ./configure \
            --prefix=$FREECAD \
            #--with-sysroot=/usr/lib/
            #--with-metis=/usr/lib/x86_64-linux-gnu/
            #--with-togl=/usr/lib/
            --with-tcl=/usr/lib/tcl8.5 \
            --with-tk=/usr/lib/tk8.5 \
            --with-occ=$FREECAD \
            --enable-occ \
            --enable-shared \
            --enable-nglib \
            --disable-gui \
            --disable-dependency-tracking \
            CPPFLAGS="-I/usr/lib/openmpi/include/" \
            CXXFLAGS="-DNGLIB_EXPORTS -std=gnu++11" \
  \
    && make -j$(nproc) \
    && make install \
    && cp -rf libsrc $FREECAD/libsrc



### get FreeCAD latest Github commit
#------------------------------------
RUN \
    cd \
    && git clone https://github.com/FreeCAD/FreeCAD \
  # building FreeCAD
    && mkdir build \
    && cd build \
  \
  # with oce-dev installed, with netgen
    && cmake ../FreeCAD  \
            -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD  \
            -DBUILD_FEM_NETGEN=1  \
            -DCMAKE_CXX_FLAGS="-DNETGEN_V5"  \
            -DNETGEN_ROOT=$FREECAD  \
            -DFREECAD_USE_OCC_VARIANT="Official Version"  \
            -DOCC_INCLUDE_DIR=$FREECAD/include/opencascade  \
            -DOCC_LIBRARY=$FREECAD/lib/libTKernel.so \
  \
    && make -j$(nproc) 
    #&& make install

# start FreeCAD
# $FREECAD/bin/FreeCAD
