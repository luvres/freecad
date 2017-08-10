FROM freecad:build-jessie
MAINTAINER Leonardo Loures <luvres@hotmail.com>

ENV FREECAD=/opt/FreeCAD

# cmake
RUN \
    VERSION=1.64
    cd && cd cmake \
    && checkinstall -Dy --install=no --pkgversion=`cmake -version | head -n1 | awk '{print $3}'`

    #--pkgname=<name>
    #dpkg -i cmake_3.9.20170809-g92d16-1_amd64.deb

    
# libBoost 1.64
# RUN \
#     VERSION=1.64 && \
#     cd && cd boost* \
#     && checkinstall -Dy --install=no --pkgversion=$VERSION


# libMED 3.2.0
#----------------
RUN \
    VERSION=3.2.0 && \
    cd && cd med/build \
    && checkinstall -Dy --install=no --pkgname=med --pkgversion=$VERSION


# VTK (Git)
#-------------
RUN \
    cd \
    && mkdir vtk \
    && cd vtk \
    && git clone https://gitlab.kitware.com/vtk/vtk.git \
  # building VTK
    && mkdir build \
    && cd build \
  \
    && cmake ../vtk \
            -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
            -DVTK_Group_Rendering:BOOL=OFF \
            -DVTK_Group_StandAlone:BOOL=ON \
            -DVTK_RENDERING_BACKEND=None \
  \
    && make -j$(nproc) \
    && make install

### libCoin 3.1.4
#-----------------
RUN apt-get install -y \
    libcoin80 \
    libcoin80-dev 
### libCoin 4.0.0a
#-----------------
# RUN \
#     apt-get install -y \
#         libgl1-mesa-dev \
#         libxi-dev \
#         libxmu-dev \
#         libxpm-dev \
#         libgl1-mesa-glx \
#         libice6 \
#         libsm6
# RUN \
#     cd \
#     && mkdir coin \
#     && cd coin \
#     && apt-get install -y mercurial \
#     && hg clone https://bitbucket.org/Coin3D/coin \
#     && cd coin \
#     && hg pull && hg update CMake \
#     && cd .. \
#     && mkdir build && cd build \
#   \
#     && cmake \
#         ../coin \
#         -DCMAKE_INSTALL_PREFIX=$FREECAD \
#         -DCOIN_BUILD_DOCUMENTATION=OFF \
#     && make -j$(nproc) \
#     && make install

### OCCT 7.1.0
#--------------
RUN \
    cd \
    && mkdir occt \
    && cd occt \
    && git clone https://github.com/luvres/occt.git \
    && cd occt \
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
        ../occt \
        -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
        -DUSE_VTK:BOOL=OFF \
  \
    && make -j$(nproc) \
    && make install

### Netgen 5.3.1
#----------------
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
  \
    && cp -rf libsrc $FREECAD/libsrc

### Eigen 3.2.2 - 3.3.0(backports)
#----------------------------------
# RUN apt-get install -y \
#     libeigen3-dev \
#
### Eigen 3.3.90 -> Bitbucket
#-----------------------------
#apt-get remove -y libeigen3-dev
RUN \
    cd \
    && mkdir eigen \
    && cd eigen \
    && apt-get install -y mercurial \
    && hg clone https://bitbucket.org/eigen/eigen \
    && mkdir build \
    && cd build \
  \
    && cmake ../eigen \
        -DCMAKE_INSTALL_PREFIX=$FREECAD \
        -DCMAKE_C_FLAGS_RELEASE=-DNDEBUG \
        -DCMAKE_CXX_FLAGS_RELEASE=-DNDEBUG \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_VERBOSE_MAKEFILE=ON \
  \
    && make install


### FreeCAD latest Github commit
#--------------------------------
# get FreeCAD
RUN \
    cd \
    && git clone https://github.com/FreeCAD/FreeCAD 

# building FreeCAD
RUN \
    cd \
    && mkdir build \
    && cd build \
  \
    && cmake ../FreeCAD \
            -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
            -DOCC_INCLUDE_DIR=$FREECAD/include/opencascade \
            -DNETGEN_ROOT=$FREECAD \
            -DBUILD_FEM_NETGEN=ON 
            #-DCMAKE_CXX_FLAGS="-DNETGEN_V5" 
            #-DFREECAD_USE_OCC_VARIANT="Official Version"  
            #-DOCC_LIBRARY=$FREECAD/lib/libTKernel.so 
            #-DEIGEN3_INCLUDE_DIR=$FREECAD/include/eigen3 

# Make FreeCAD
RUN \
    cd \
    && cd build \
    && make -j$(nproc) 
    
#    && make install
# 
## start FreeCAD
# $FREECAD/bin/FreeCAD


### Calculix 2.12 and CGX
#-------------------------
RUN \
    ccx_VERSION=2.12 && \
    apt-get install -y gfortran cpio \
    && cd \
    && git clone https://github.com/luvres/calculix.git \
    && cd calculix/ \
    && ./install \
    && cp $HOME/CalculiX-${ccx_VERSION}/bin/ccx_${ccx_VERSION} /usr/bin/ccx \
    && cp $HOME/CalculiX-${ccx_VERSION}/bin/cgx /usr/bin/cgx \
    && cd && rm CalculiX-${ccx_VERSION} calculix -fR
