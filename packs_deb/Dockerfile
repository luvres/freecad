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

RUN \
    apt-get update && apt-get install -y checkinstall

## cmake
#--------
RUN \
    NAME=cmake && \
    VERSION=`cmake -version | head -n1 | awk '{print $3}'` && \
    RELEASE=jessie && \
    cd && cd cmake \
  \
    && checkinstall -Dy \
        --pkgsource="https://gitlab.kitware.com/cmake/cmake" \
        --pkglicense="GPL3" \
        --maintainer="Leonardo Loures \\<luvres@hotmail.com\\>" \
        --nodoc \
        --pkgarch=$(dpkg --print-architecture) \
        --install=no \
        --pkgname=$NAME \
        --pkgversion=$VERSION \
        --pkgrelease=$RELEASE \
  \
    && cp $NAME*.deb /mnt

    
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
RUN \
    NAME=med && \   
    VERSION=3.2.0 && \
    RELEASE=jessie && \
    cd && cd med/build \
  \
    && checkinstall -Dy \
        --pkgsource="http://salome-platform.org/" \
        --pkglicense="GPL3" \
        --maintainer="Leonardo Loures \\<luvres@hotmail.com\\>" \
        --nodoc \
        --pkgarch=$(dpkg --print-architecture) \
        --install=no \
        --pkgname=$NAME \
        --pkgversion=$VERSION \
        --pkgrelease=$RELEASE \
  \
    && cp $NAME*.deb /mnt


## VTK (Git)
#-------------
RUN \
    NAME=vtk && \ 
    VERSION=8.1 && \
    RELEASE=jessie && \
    cd && cd vtk/build \
  \
    && checkinstall -Dy \
        --pkgsource="https://gitlab.kitware.com/vtk/vtk" \
        --pkglicense="BSD3" \
        --maintainer="Leonardo Loures \\<luvres@hotmail.com\\>" \
        --nodoc \
        --pkgarch=$(dpkg --print-architecture) \
        --install=no \
        --pkgname=$NAME \
        --pkgversion=$VERSION \
        --pkgrelease=$RELEASE \
  \
    && cp $NAME*.deb /mnt


## OCCT 7.1.0
#-------------
RUN \
    NAME=occt && \
    VERSION=7.1.0 && \
    RELEASE=jessie && \
    cd && cd occt/build \
  \
    && checkinstall -Dy \
        --pkgsource="http://git.dev.opencascade.org/gitweb/?p=occt.git;a=summary" \
        --pkglicense="GPL2" \
        --maintainer="Leonardo Loures \\<luvres@hotmail.com\\>" \
        --nodoc \
        --pkgarch=$(dpkg --print-architecture) \
        --install=no \
        --pkgname=$NAME \
        --pkgversion=$VERSION \
        --pkgrelease=$RELEASE \
  \
    && cp $NAME*.deb /mnt


## Netgen 5.3.1
#----------------
RUN \
    NAME=netgen-occt && \
    VERSION=5.3.1 && \
    RELEASE=jessie && \
    cd && cd netgen \
  \
    && checkinstall -Dy \
        --pkgsource="https://sourceforge.net/projects/netgen-mesher/files/netgen-mesher/5.3/" \
        --pkglicense="LGPL2.1" \
        --maintainer="Leonardo Loures \\<luvres@hotmail.com\\>" \
        --nodoc \
        --install=no \
        --pkgname=$NAME \        
        --pkgversion=$VERSION \
        --pkgrelease=$RELEASE \
  \
    && cp $NAME*.deb /mnt


## Eigen 3.3.90 -> Bitbucket
#----------------------------
RUN \
    NAME=eigen && \
    VERSION=3.3.90 && \
    RELEASE=jessie && \
    cd && cd eigen/build \
  \
    && checkinstall -Dy \
        --pkgsource="http://eigen.tuxfamily.org/index.php?title=Main_Page" \
        --pkglicense="MPL2" \
        --nodoc \
        --install=no \
        --pkgname=$NAME \
        --pkgversion=$VERSION \
        --pkgrelease=$RELEASE \
  \
    && cp $NAME*.deb /mnt


### FreeCAD latest Github commit
#--------------------------------
RUN \
    NAME=FreeCAD && \
    VERSION=0.17 && \
    RELEASE=jessie && \
    cd && cd build \
  \
    && checkinstall -Dy \
        --pkgsource="http://eigen.tuxfamily.org/index.php?title=Main_Page" \
        --pkglicense="GPL2" \
        --nodoc \
        --install=no \
        --pkgname=$NAME \
        --pkgversion=$VERSION \
        --pkgrelease=$RELEASE \
  \
    && cp $NAME*.deb /mnt
    

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
