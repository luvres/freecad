FROM izone/freecad:nvidia-stretch
MAINTAINER Leonardo Loures <luvres@hotmail.com>

# References:
# https://gist.github.com/berndhahnebach/38d5bfe73134928c0a1ad001a94df05f
# https://github.com/berndhahnebach/Netgen
# https://sourceforge.net/p/netgen-mesher/wiki/Home/
# https://aur.archlinux.org/packages

ENV FREECAD=/opt/local/FreeCAD-0.17
RUN \
    cd \
    && mkdir -p $FREECAD \
  \
    && package_deps=" doxygen \
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
                      libqtwebkit-dev \
                      shiboken \
                      swig " \
  \
    && package_boost=" libboost1.62-dev \
                       libboost-filesystem1.62-dev \
                       libboost-program-options1.62-dev \
                       libboost-python1.62-dev \
                       libboost-regex1.62-dev \
                       libboost-signals1.62-dev \
                       libboost-system1.62-dev \
                       libboost-thread1.62-dev " \
  \
    && package_build=" python-pivy \
                       cmake \
                       g++ \
                       libfreetype6-dev \
                       tcl8.5-dev \
                       tk8.5-dev \
                       automake \
                       libtogl-dev \
                       libhdf5-dev " \
  \
    && apt-get update \
  \
    && apt-get install -y \
      \
        $package_deps \
        $package_boost \
        $package_build \
      \
        dictionaries-common \
        wget \
        git \
        gmsh \
        calculix-ccx

### libMED 3.0.6
#----------------
# RUN apt-get install -y \
#     libmed-dev \
#     libmedc-dev
#
### libMED 3.2.0
#----------------
RUN \
    cd \
    && mkdir med \
    && cd med \
    && git clone https://github.com/luvres/libMED.git \
  \
  # building MED
    && mkdir build \
    && cd build \
  \
    && cmake ../libMED \
        -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
  \
    && make -j$(nproc) \
    && make install

### VTK 8.0.0
#-------------
RUN \
    vtk_VERSION_MAJOR=8.0 && \
    vtk_VERSION_MINOR=8.0.0 && \
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

### libCoin 3.1.4
#-----------------
RUN apt-get install -y \
    libcoin80v5 \
    libcoin80-dev 

### OCCT 7.1.0
#--------------
RUN \
    #url_OCCT="http://git.dev.opencascade.org/gitweb/?p=occt.git;a=snapshot;h=1780d6cc299f1d06eb106f5cfc27731cdaf97a56;sf=tgz" && 
    url_OCCT="http://desktop/Workstation/occt-7.1.0p1.tgz" && \
    dir_OCCT=1780d6c && \
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

### Eigen 3.3.2
#---------------
# RUN apt-get install -y \
#     libeigen3-dev \

### Eigen 3.3.90 -> Bitbucket
#----------------------------
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
RUN \
    cd \
    && git clone https://github.com/FreeCAD/FreeCAD \
  # building FreeCAD
    && mkdir build \
    && cd build \
  \
  # with oce-dev installed, with netgen
    && cmake ../FreeCAD \
            -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
            -DOCC_INCLUDE_DIR=$FREECAD/include/opencascade \
            -DNETGEN_ROOT=$FREECAD \
            -DBUILD_FEM_NETGEN=ON \
            #-DCMAKE_CXX_FLAGS="-DNETGEN_V5" 
            #-DFREECAD_USE_OCC_VARIANT="Official Version"  
            #-DOCC_LIBRARY=$FREECAD/lib/libTKernel.so 
            #-DEIGEN3_INCLUDE_DIR=$FREECAD/include/eigen3 
  \
    && make -j$(nproc) 
#    && make install
# 
# start FreeCAD
# $FREECAD/bin/FreeCAD


### Calculix 2.12 and CGX
#-------------------------
# RUN \
#     ccx_VERSION=2.12 && \
#     apt-get install -y gfortran cpio \
#     && cd \
#     && git clone https://github.com/luvres/calculix.git \
#     && cd calculix/ \
#     && ./install \
#     && cp $HOME/CalculiX-${ccx_VERSION}/bin/ccx_${ccx_VERSION} /usr/bin/ccx \
#     && cp $HOME/CalculiX-${ccx_VERSION}/bin/cgx /usr/bin/cgx \
#     && cd && rm CalculiX-${ccx_VERSION} calculix -fR
