FROM izone/freecad:nvidia-sid
MAINTAINER Leonardo Loures <luvres@hotmail.com>

RUN \
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
    && apt-get update \
    && apt install -y \
                libgl1-mesa-dri \
                $pack_build \
                gmsh \
                calculix-cxx
                

RUN \
  # get FreeCAD Git
    cd \
    && git clone https://github.com/FreeCAD/FreeCAD.git \
    && mkdir freecad-build && cd freecad-build \
  \
  # Build
    && cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_FEM_NETGEN=ON ../FreeCAD \
  \
    && make -j$(nproc)

#     && make install \
#     && cd \
#   \
#   # Clean
#     && rm FreeCAD/ freecad-build/ -fR \
#     && ln -s /usr/local/bin/FreeCAD /usr/bin/freecad-git


# # Calculix
# ENV CCX_VERSION=2.12
# RUN apt-get install -y gfortran xorg-dev wget cpio \
#     && cd \
#     && git clone https://github.com/luvres/graphics.git \
#     && cd graphics/calculix-$CCX_VERSION/ \
#     && ./install \
#     && cp $HOME/CalculiX-$CCX_VERSION/bin/ccx_$CCX_VERSION /usr/bin/ccx \
#     && cp $HOME/CalculiX-$CCX_VERSION/bin/cgx /usr/bin/cgx \
#     && cd && rm CalculiX-$CCX_VERSION graphics -fR
# 
# # Clean
# RUN apt-get clean \
#     && rm /var/lib/apt/lists/* \
#           /usr/share/doc/* \
#           /usr/share/locale/* \
#           /usr/share/man/* \
#           /usr/share/info/* -fR    
