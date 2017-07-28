FROM ubuntu:xenial
MAINTAINER Leonardo Loures <luvres@hotmail.com>

# References:
# https://gist.github.com/berndhahnebach/38d5bfe73134928c0a1ad001a94df05f
# https://github.com/berndhahnebach/Netgen
# https://sourceforge.net/p/netgen-mesher/wiki/Home/

ENV FREECAD=/opt/local/FreeCAD-0.17
RUN \
    cd \
    && mkdir -p $FREECAD \
    \
    && package_list=" doxygen \
                      libboost1.58-dev \
                      libboost-filesystem1.58-dev \
                      libboost-program-options1.58-dev \
                      libboost-python1.58-dev \
                      libboost-regex1.58-dev \
                      libboost-signals1.58-dev \
                      libboost-system1.58-dev \
                      libboost-thread1.58-dev \
                      libcoin80v5 \
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
                      libqtwebkit-dev \
                      shiboken \
                      calculix-ccx \
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
        # sudo apt-get install -y tcl8.5  # to run DRAWEXE of occt, but it does not run either
        tcl8.5-dev \
        tk8.5-dev \
        automake \
        # netgen
        libtogl-dev \
        libhdf5-dev

### get MED
#-----------
RUN cd \
#    && cd $base_dir
    && mkdir med \
    && cd med \
    && git clone https://github.com/berndhahnebach/libMED.git \
  # building MED
    && mkdir build \
    && cd build \
    && cmake ../libMED -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
    && make -j$(nproc) \
    && make install

### get VTK 7.0.0
#-----------------
RUN cd \
#    && cd $base_dir
    && mkdir vtk \
    && cd vtk \
    && wget http://www.vtk.org/files/release/7.0/VTK-7.0.0.tar.gz \
    && gunzip VTK-7.0.0.tar.gz \
    && tar xf VTK-7.0.0.tar \
    && rm VTK-7.0.0.tar \
  # building VTK
    && mkdir build \
    && cd build \
  \
    && cmake ../VTK-7.0.0 \
            -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
            -DVTK_Group_Rendering:BOOL=OFF \
            -DVTK_Group_StandAlone:BOOL=ON \
            -DVTK_RENDERING_BACKEND=None \
  \
    && make -j$(nproc) \
    && make install

### get OCCT 7.1.0
#------------------
RUN cd \
#    && cd $base_dir
    && mkdir occt \
    && cd occt \
#   && wget "http://git.dev.opencascade.org/gitweb/?p=occt.git;a=snapshot;h=89aebdea8d6f4d15cfc50e9458cd8e2e25022326;sf=tgz" -O occt.tgz
    && wget -c "http://desktop/Workstation/index.html%3fp%3docct.git%3ba%3dsnapshot%3bh%3d89aebdea8d6f4d15cfc50e9458cd8e2e25022326%3bsf%3dtgz" -O occt.tgz \
    && gunzip occt.tgz \
    && tar xf occt.tar \
    && rm occt.tar \
    && cd occt-89aebde \
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
        ../occt-89aebde \
        -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
        -DUSE_VTK:BOOL=OFF \
  \
    && make -j$(nproc) \
    && make install

### get Netgen 5.3.1
#--------------------
RUN cd \
    && apt-get install -y \
    openmpi-bin libopenmpi-dev \ 
    #metis libtogl-dev
    && mkdir netgen \
    && cd netgen \
    && git clone https://github.com/berndhahnebach/Netgen \
  # building Netgen
    && cd Netgen/netgen-5.3.1 \
  \
    ##&& sed -i '/DOCCGEOMETRY/s/\/usr\/local/$occdir/' configure
    ##&& sed -i '/DOCCGEOMETRY/s/\/usr/$occdir/' configure
    ##&& sed -i '/DOCCGEOMETRY/s/\/usr/$occdir/' configure.ac
    ##&& sed -i '/DOCCGEOMETRY/s/inc/include/' configure.ac
    ## curl -L https://github.com/FreeCAD/homebrew-freecad/releases/download/0/nglib-occt7.patch | patch -p1
  \
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
            CXXFLAGS="-DNGLIB_EXPORTS -std=gnu++11"

#   && make -j$(nproc)
#    && make install \
#    # copy libsrc, FreeCAD needs it
#    && cd $base_dir \
#    && cd netgen \
#    && cp -rf Netgen/netgen-5.3.1/libsrc  $FREECAD/libsrc


### get FreeCAD latest Github commit
#------------------------------------
# RUN cd \
#     && mkdir freecad \
#     && cd freecad \
#     && git clone https://github.com/FreeCAD/FreeCAD \
#   # building FreeCAD
#     && mkdir build \
#     && cd build

# with oce-dev installed, with netgen
# RUN cmake ../FreeCAD  \
#     -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD  \
#     -DBUILD_FEM_NETGEN=1  \
#     -DCMAKE_CXX_FLAGS="-DNETGEN_V5"  \
#     -DNETGEN_ROOT=$FREECAD  \
#     -DFREECAD_USE_OCC_VARIANT="Official Version"  \
#     -DOCC_INCLUDE_DIR=$FREECAD/include/opencascade  \
#     -DOCC_LIBRARY=$FREECAD/lib/libTKernel.so
# RUN make 
# RUN make install


### start FreeCAD
#-----------------
# $FREECAD/bin/FreeCAD
