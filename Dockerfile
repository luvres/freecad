FROM izone/freecad:nvidia
MAINTAINER Leonardo Loures <luvres@hotmail.com>

#RUN apt update \
#    && apt install -y software-properties-common \    
#    && add-apt-repository -y ppa:freecad-maintainers/freecad-daily
    
RUN apt-get update \
    && apt install -y \
    git \
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
    python-pivy \
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
    libproj-dev \
    gmsh
    
RUN cd \
    && git clone https://github.com/FreeCAD/FreeCAD.git \
    && mkdir freecad-build && cd freecad-build \
    && cmake -DCMAKE_BUILD_TYPE=Debug -DBUILD_FEM_NETGEN=ON ../FreeCAD \
    && make -j$(nproc) \
    && make install \
    && cd \
    && rm FreeCAD/ freecad-build/ -fR \
    && ln -s /usr/local/bin/FreeCAD /usr/bin/freecad-daily

RUN apt install -y gfortran xorg-dev wget cpio \
    && cd \
    && git clone https://github.com/luvres/graphics.git \
    && cd graphics/calculix-2.12/ \
    && ./install \
    && cp $HOME/CalculiX-2.12/bin/ccx_2.12 /usr/bin/ccx \
    && cp $HOME/CalculiX-2.12/bin/cgx /usr/bin/cgx \
    && cd && rm CalculiX-2.12 graphics -fR
