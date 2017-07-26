FROM izone/freecad:nvidia-sid
MAINTAINER Leonardo Loures <luvres@hotmail.com>

ENV FREECAD=/opt/local/FreeCAD-0.17
RUN \
    cd \
    && mkdir -p $FREECAD \
#    && rm -rf build_FreeCAD
#    && mkdir build_FreeCAD
#    && cd build_FreeCAD
#    && base_dir=`pwd`
    \
    pack_build="git \
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
        # sudo apt-get install -y tcl8.5  # to run DRAWEXE of occt, but it does not run either
        tcl8.5-dev \
        tk8.5-dev \
        automake \
        # netgen
        libtogl-dev libhdf5-dev

# get MED
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

# get VTK 7.0.0
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

# get OCCT 7.1.0
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

# get Netgen 5.3.1
RUN cd \
#    && cd $base_dir
    && mkdir netgen \
    && cd netgen \
    && git clone https://github.com/berndhahnebach/Netgen \
  # building Netgen
    && cd Netgen/netgen-5.3.1 \
  \
    && ./configure \
            --prefix=$FREECAD \
            --with-tcl=/usr/lib/tcl8.5 \
            --with-tk=/usr/lib/tk8.5 \
            --enable-occ \
            --with-occ=$FREECAD \
            --disable-gui \
            --disable-dependency-tracking \
            \
            --enable-shared \
            --enable-nglib \
            CPPFLAGS="-I$FREECAD/include/opencascade/" \
            CXXFLAGS="-DNGLIB_EXPORTS -std=gnu++11"

#   && make -j$(nproc)
#    && make install \
#    # copy libsrc, FreeCAD needs it
#    && cd $base_dir \
#    && cd netgen \
#    && cp -rf Netgen/netgen-5.3.1/libsrc  $FREECAD/libsrc



# get FreeCAD latest Github commit
# RUN cd $base_dir \
#     && mkdir freecad \
#     && cd freecad \
#     && git clone https://github.com/FreeCAD/FreeCAD \
# # building FreeCAD
#     && mkdir build \
#     && cd build
# # with oce-dev installed, with netgen
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

# start FreeCAD
# $FREECAD/bin/FreeCAD


#----------------------------------#
# # no oce-dev packages, no netgen
# # cmake \
#     ../FreeCAD \
#     -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
#     -DOCC_INCLUDE_DIR=$FREECAD/include/opencascade
# 
# # with oce-dev installed, no netgen
# # cmake \
#     ../FreeCAD \
#     -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
#     -DFREECAD_USE_OCC_VARIANT="Official Version" \
#     -DOCC_INCLUDE_DIR=$FREECAD/include/opencascade \
#     -DOCC_LIBRARY=$FREECAD/lib/libTKernel.so
# 
# # no oce-dev packages, with netgen
# # cmake \
#     ../FreeCAD \
#     -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
#     -DBUILD_FEM_NETGEN=1 \
#     -DCMAKE_CXX_FLAGS="-DNETGEN_V5" \
#     -DNETGEN_ROOT=$FREECAD \
#     -DOCC_INCLUDE_DIR=$FREECAD/include/opencascade
#----------------------------------#
