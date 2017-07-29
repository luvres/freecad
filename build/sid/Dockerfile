FROM izone/freecad:nvidia-sid
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
    && package_list=" git \
                      build-essential \
                      cmake \
                      python \
                      python-matplotlib \
                      libtool \
                      libcoin80-dev \
                      libsoqt4-dev \
                      libxerces-c-dev \
                      libboost-dev \
                      libboost-filesystem-dev \
                      libboost-regex-dev \
                      libboost-program-options-dev \
                      libboost-signals-dev \
                      libboost-thread-dev \
                      libboost-python-dev \
                      libqt4-dev \
                      libqt4-opengl-dev \
                      qt4-dev-tools \
                      python-dev \
                      python-pyside \
                      pyside-tools \
                      liboce-modeling-dev \
                      liboce-visualization-dev \
                      liboce-foundation-dev \
                      liboce-ocaf-lite-dev \
                      liboce-ocaf-dev \
                      oce-draw \
                      libeigen3-dev \
                      libqtwebkit-dev \
                      libshiboken-dev \
                      libpyside-dev \
                      libode-dev \
                      swig \
                      libzipios++-dev \
                      libfreetype6 \
                      libfreetype6-dev \
                      netgen-headers \
                      libmedc-dev \
                      libvtk6-dev \
                      libproj-dev " \
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
        libhdf5-dev

### get libMED 3.2.0
#--------------------
RUN \
    cd \
    && mkdir med \
    && cd med \
    && git clone https://github.com/berndhahnebach/libMED.git \
  \
  # building MED
    && mkdir build \
    && cd build \
    && cmake ../libMED -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
    && make -j$(nproc) \
    && make install

### get VTK 7.0.0
#-----------------
# 7.0 - 7.0.0
# 7.1 - 7.1.1
# 8.0 - 8.0.0
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

### get OCCT 7.1.0
#------------------
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
