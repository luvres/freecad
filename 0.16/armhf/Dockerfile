FROM arm32v7/debian:jessie-slim
MAINTAINER Leonardo Loures <luvres@hotmail.com>

COPY qemu-arm-static /usr/bin/qemu-arm-static

ENV FREECAD=/usr
RUN mkdir -p $FREECAD 

### Packages deps
#-----------------
RUN apt-get update \
    && apt-get install -y \
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
		calculix-ccx


### FreeCAD latest Github commit
#--------------------------------
# get FreeCAD
RUN \
	cd \
	&& git clone https://github.com/luvres/FreeCAD-0.16.6712.git

# building FreeCAD
RUN \
	cd \
	&& mkdir build \
	&& cd build \
  \
	cmake ../FreeCAD-0.16.6712 \
			-DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
			-DBUILD_FEM_NETGEN=ON \
			-DCMAKE_INSTALL_PREFIX="/usr/lib/freecad"

# Make FreeCAD
RUN \
	cd \
	&& cd build \
	&& make -j$(nproc)

# Install
RUN \
	cd \
	&& cd build \
	&& make install \
	&& cd && rm FreeCAD-0.16.6712/ build/ -fR
 

### Calculix 2.12 and CGX
#-------------------------
#RUN \
#	ccx_VERSION=2.12 && \
#	apt-get install -y gfortran cpio \
#	&& cd \
#	&& git clone https://github.com/luvres/calculix.git \
#	&& cd calculix/ \
#	&& ./install \
#	&& cp $HOME/CalculiX-${ccx_VERSION}/bin/ccx_${ccx_VERSION} /usr/bin/ccx \
#	&& cp $HOME/CalculiX-${ccx_VERSION}/bin/cgx /usr/bin/cgx \
#	&& cd && rm CalculiX-${ccx_VERSION} calculix -fR

