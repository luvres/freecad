FROM izone/freecad:nvidia
MAINTAINER Leonardo Loures <luvres@hotmail.com>

#RUN apt update \
#    && apt install -y software-properties-common \    
#    && add-apt-repository -y ppa:freecad-maintainers/freecad-daily
    
RUN apt-get update \
    && apt install -y \
    git \
    cmake \
    doxygen \
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
    liboce-foundation-dev \
    liboce-modeling-dev \
    liboce-ocaf-dev \
    liboce-ocaf-lite-dev \
    liboce-visualization-dev \
    libpyside-dev \
    libqtcore4 \
    libshiboken-dev \
    libxerces-c-dev \
    libxmu-dev \
    libxmu-headers \
    libxmu6 \
    libxmuu-dev \
    libxmuu1 \
    netgen-headers \
    oce-draw \
    pyside-tools \
    python-dev \
    python-pyside \
    python-matplotlib \
    qt4-dev-tools \
    qt4-qmake \
    shiboken \
    swig \
    libvtk6-dev \
    libmed-dev \
    libmedc-dev \
    \
    libeigen3-dev
    
RUN cd \
    && git clone https://github.com/FreeCAD/FreeCAD.git \
    && mkdir freecad-build && cd freecad-build \
    && cmake -DCMAKE_BUILD_TYPE=Debug -DBUILD_FEM_NETGEN=ON ../FreeCAD \
    && make -j$(grep "model name" /proc/cpuinfo | wc -l)
    
RUN ln -s $HOME/freecad-build/bin/FreeCAD /usr/bin/freecad-daily

RUN apt install -y gfortran xorg-dev wget \
    && cd \
    && git clone https://github.com/luvres/graphics.git \
    && cd graphics/calculix-2.12/ \
    && ./install \
    && cp $HOME/CalculiX-2.12/bin/ccx_2.12 /usr/bin/ccx \
    && cp $HOME/CalculiX-2.12/bin/cgx /usr/bin/cgx
