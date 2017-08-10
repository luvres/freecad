FROM freecad:build-jessie
MAINTAINER Leonardo Loures <luvres@hotmail.com>

ENV FREECAD=/opt/FreeCAD

## cmake
#--------
RUN \
    VERSION=`cmake -version | head -n1 | awk '{print $3}'`
    cd && cd cmake \
  \
    && checkinstall -Dy \
        --install=no \
        --pkgversion=$VERSION

    
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
    VERSION=3.2.0 && \
    cd && cd med/build \
  \
    && checkinstall -Dy \
        --install=no \
        --pkgname=med \
        --pkgversion=$VERSION


## VTK (Git)
#-------------
RUN \
    VERSION=8.1 && \
    cd && cd vtk/build \
  \
    && checkinstall -Dy \
        --install=no \
        --pkgname=vtk \
        --pkgversion=$VERSION


## OCCT 7.1.0
#-------------
RUN \
    VERSION=7.1.0 && \
    cd && cd occt/build \
  \
    && checkinstall -Dy \
        --install=no \
        --pkgname=occt \
        --pkgversion=$VERSION


### Netgen 5.3.1
#----------------
RUN \
    VERSION=5.3.1 && \
    cd && cd netgen \
  \
    && checkinstall -Dy \
        --install=no \
        --pkgname=netgen5 \
        --pkgversion=$VERSION \
        --include=libsrc \
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
