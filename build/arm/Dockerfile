FROM izone/freecad:nvidia-jessie
#FROM arm32v7/debian:jessie-slim
#FROM arm64v8/debian:jessie-slim

MAINTAINER Leonardo Loures <luvres@hotmail.com>

## References:
# https://gist.github.com/berndhahnebach/38d5bfe73134928c0a1ad001a94df05f
# https://github.com/berndhahnebach/Netgen
# https://sourceforge.net/p/netgen-mesher/wiki/Home/
# https://aur.archlinux.org/packages
# http://www.boost.org/doc/libs/1_64_0/more/getting_started/unix-variants.html

ENV FREECAD=/opt/FreeCAD
RUN mkdir -p $FREECAD 

### Packages deps
#-----------------
RUN apt-get update \
    && apt-get install -y \
		doxygen \
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
		swig

### Packages build
#------------------
RUN apt-get install -y \
		python-pivy \
		g++ \
		libfreetype6-dev \
		tcl8.5-dev \
		tk8.5-dev \
		automake \
		libhdf5-dev \
	  \
		dictionaries-common \
		wget \
		git \
		gmsh

### cmake 3.0.2
#---------------
RUN apt-get install -y \
    cmake 

### libBoost 1.55
#-----------------
RUN apt-get install -y \
		libboost1.55-dev \
		libboost-filesystem1.55-dev \
		libboost-program-options1.55-dev \
		libboost-python1.55-dev \
		libboost-regex1.55-dev \
		libboost-signals1.55-dev \
		libboost-system1.55-dev \
		libboost-thread1.55-dev

### libMED 3.0.6
#----------------
#RUN apt-get install -y \
#		libmed-dev \
#		libmedc-dev
### libMED 3.2.0
#-------------
RUN \
    med_VERSION=3.2.0 && \
    wget -c http://pi/FreeCAD/packages/med_${med_VERSION}-jessie_amd64.deb \
    &&dpkg -i med_${med_VERSION}-jessie_amd64.deb

### libCoin 3.1.4
#-----------------
RUN apt-get install -y \
		libcoin80 \
		libcoin80-dev 

### Eigen 3.2.2 - 3.3.0(backports)
#----------------------------------
RUN apt-get install -y \
  	  libeigen3-dev 


### OCCT 7.1.0
#-------------
RUN \
	apt-get install -y \
		libfreeimage3 \
		libtbb2 \
	&& \
    occt_VERSION=7.1.0 && \
    wget -c http://pi/FreeCAD/packages/occt_${occt_VERSION}-jessie_amd64.deb \
    && dpkg -i occt_${occt_VERSION}-jessie_amd64.deb


####################
### VTK 7.1.1
#-------------
RUN \
    vtk_VERSION=7.1.1 && \
    wget -c http://pi/FreeCAD/packages/vtk_${vtk_VERSION}-jessie_amd64.deb \
    && dpkg -i vtk_${vtk_VERSION}-jessie_amd64.deb


### FreeCAD latest Github commit
#--------------------------------
# get FreeCAD
RUN \
    cd \
    && git clone https://github.com/FreeCAD/FreeCAD 
####################
####################


### Netgen 5.3.1
#----------------
#RUN \
#	apt-get install -y \
#		liboce-ocaf-lite8 \
#		liboce-ocaf8 \
#		liboce-visualization8 \
#		&& \
#    netgen_VERSION=5.3.1 && \
#    wget -c http://pi/FreeCAD/packages/netgen_${netgen_VERSION}-jessie_amd64.deb \
#    && dpkg -i netgen_${netgen_VERSION}-jessie_amd64.deb
#
#### Netgen 5.3.1
##----------------
#RUN \
#    cd \
#    && apt-get install -y \
#		openmpi-bin \
#		libopenmpi-dev \
#		libtogl-dev \
#    && git clone https://github.com/luvres/netgen.git \
#    && cd netgen \
#  \
#  # building Netgen
#    && ./configure \
#            --prefix=/usr \
#            --enable-occ \
#            --with-occ=/usr \
#            --with-tcl=/usr/lib/tcl8.5 \
#            --with-tk=/usr/lib/tk8.5 \
#            --with-togl=/usr/lib/ \
#            --enable-shared \
#            --enable-nglib \
#            --disable-gui \
#            --disable-dependency-tracking \
#            CXXFLAGS="-DNGLIB_EXPORTS -std=gnu++11" \
#  \
#    && make -j$(nproc) \
#    && make install \
#  \
#    && cp -fR libsrc /usr/share/netgen 
#  \
#    && cd && rm netgen -fR 

#### Netgen 5.3.1
##----------------
RUN \
    cd \
    && apt-get install -y curl \
		openmpi-bin \
		libopenmpi-dev \
		libtogl-dev \
    && wget https://sourceforge.net/projects/netgen-mesher/files/netgen-mesher/5.3/netgen-5.3.1.tar.gz \
	&& tar zxf netgen-5.3.1.tar.gz \
	&& rm netgen-5.3.1.tar.gz \
    && cd netgen-5.3.1 \
  \
	&& curl -L https://git.launchpad.net/~freecad-maintainers/+git/netgen/plain/debian/patches/nglib-occt7.patch | patch -p1 \
#	&& curl -L https://raw.githubusercontent.com/luvres/netgen/master/nglib-occt7.patch | patch -p1 
  \
#	&& sed -i '/DOCCGEOMETRY/s/\/usr/$occdir/' configure 
#	&& sed -i '/DOCCGEOMETRY/s/inc/include/' configure 
#	&& sed -i '/DOCCGEOMETRY/s/\/usr/$occdir/' configure.ac 
#	&& sed -i '/DOCCGEOMETRY/s/inc/include/' configure.ac 
  \
  # building Netgen
    && ./configure \
            --prefix=/usr \
            --enable-occ \
            --with-occ=/usr \
            --with-tcl=/usr/lib/tcl8.5 \
            --with-tk=/usr/lib/tk8.5 \
            --with-togl=/usr/lib/ \
            --enable-shared \
            --enable-nglib \
            --disable-gui \
            --disable-dependency-tracking \
            CXXFLAGS="-DNGLIB_EXPORTS -std=gnu++11" \
  \
    && make -j$(nproc) \
    && make install \
  \
    && cp -fR libsrc /usr/share/netgen 

# building FreeCAD
RUN \
    cd \
    && mkdir build \
    && cd build \
  \
    && cmake ../FreeCAD \
            -DCMAKE_INSTALL_PREFIX:PATH=/usr \
            -DOCC_INCLUDE_DIR=/usr/include/opencascade \
            -DNETGEN_ROOT=/usr/share/netgen \
            -DBUILD_FEM_NETGEN=ON \
            #-DCMAKE_CXX_FLAGS="-DNETGEN_V5" 
            #-DFREECAD_USE_OCC_VARIANT="Official Version"  
            -DOCC_LIBRARY=/usr/lib/libTKernel.so 
            #-DEIGEN3_INCLUDE_DIR=/usr/include/eigen3 

### Make FreeCAD
RUN \
    cd \
    && cd build \
    && make -j$(nproc) 
    
#    && make install \
#  \
#  # Clean
#    && cd && rm FreeCAD/ build/ -fR 
 
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

