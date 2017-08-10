FROM freecad:build-jessie
MAINTAINER Leonardo Loures <luvres@hotmail.com>

# docker build -t freecad:deb ./packs_deb/
#
# docker run -ti --rm --name FreeCAD \
# --net=host \
# -e DISPLAY=unix$DISPLAY \
# -v /tmp/.X11-unix \
# -v $HOME/.Xauthority:/root/.Xauthority \
# -v $HOME/1uvr3z/packages:/mnt \
# freecad:build-jessie bash

RUN apt-get install checkinstall

## cmake
#--------
RUN \
    VERSION=`cmake -version | head -n1 | awk '{print $3}'` \
    cd && cd cmake \
  \
    && checkinstall -Dy \
        --pkgsource="https://gitlab.kitware.com/cmake/cmake" \
        --pkglicense="GPL3" \
        --maintainer="Leonardo Loures \\<luvres@hotmail.com\\>" \
        --nodoc \
        --pkgarch=$(dpkg --print-architecture) \
        --install=no \
        --pkgname=cmake \
        --pkgversion=$VERSION \
  \
    && cp cmake*.deb /mnt

    
## libBoost 1.64
#----------------
# RUN \
#     VERSION=1.64 && \
#     cd && cd boost* \
#     && checkinstall -Dy \
#     --install=no \
#     --pkgname=libBoost \
#     --pkgversion=$VERSION


## libMED 3.2.0
#---------------
# # RUN \
# #     VERSION=3.2.0 && \
# #     cd && cd med/build \
# #   \
# #     && checkinstall -Dy \
# #         --install=no \
# #         --pkgname=med \
# #         --pkgversion=$VERSION


## VTK (Git)
#-------------
# # RUN \
# #     VERSION=8.1 && \
# #     cd && cd vtk/build \
# #   \
# #     && checkinstall -Dy \
# #         --install=no \
# #         --pkgname=vtk \
# #         --pkgversion=$VERSION


## OCCT 7.1.0
#-------------
# # RUN \
# #     VERSION=7.1.0 && \
# #     cd && cd occt/build \
# #   \
# #     && checkinstall -Dy \
# #         --install=no \
# #         --pkgname=occt \
# #         --pkgversion=$VERSION


## Netgen 5.3.1
#----------------
# # RUN 
# #     VERSION=5.3.1 && \
# #     cd && cd netgen \
# #   \
# #     && checkinstall -Dy \
# #         --install=no \
# #         --pkgname=netgen5 \
# #         --pkgversion=$VERSION 


## Eigen 3.3.90 -> Bitbucket
#----------------------------
# # RUN \
# #     VERSION=3.3.90 && \
# #     cd && cd eigen/build \
# #   \
# #     && checkinstall -Dy \
# #         --pkgsource="http://eigen.tuxfamily.org/index.php?title=Main_Page" \
# #         --pkglicense="GPL3" \
# #         --nodoc \
# #         --install=no \
# #         --pkgname=eigen \
# #         --pkgversion=$VERSION


### FreeCAD latest Github commit
#--------------------------------
# # RUN \
# #     VERSION=0.17 && \
# #     cd && cd build \
# #   \
# #     && checkinstall -Dy \
# #         --install=no \
# #         --pkgname=FreeCAD \
# #         --pkgversion=$VERSION


## Calculix 2.12 and CGX
#------------------------
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
