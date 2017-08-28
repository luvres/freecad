FROM arm32v7/debian:jessie-slim
MAINTAINER Leonardo Loures <luvres@hotmail.com>

COPY qemu-arm-static /usr/bin/qemu-arm-static

ENV FREECAD=/opt/FreeCAD
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
		liboce-ocaf-dev
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
		netgen-headers


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
### cmake (Git)
#---------------
#RUN \
#    cd \
#    #&& apt-get install -y 
#    #    git g++ make 
#    && git clone https://gitlab.kitware.com/cmake/cmake.git \
#    && cd cmake \
#    && ./bootstrap --prefix=/usr \
#    && make -j$(nproc) \
#    #cp bin/cmake /usr/bin/
#    #alias cmake='/root/cmake/bin/cmake'
#    && make install

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
### libBoost 1.64 
#-----------------
# http://www.boost.org/doc/libs/1_64_0/more/getting_started/unix-variants.html
#RUN \
#    VERSION=64 && \
#  \
#    cd \
#    && wget https://downloads.sourceforge.net/project/boost/boost/1.${VERSION}.0/boost_1_${VERSION}_0.tar.bz2 \
#    && tar jxf boost_1_${VERSION}_0.tar.bz2 \
#    && rm boost_1_${VERSION}_0.tar.bz2 \
#    && cd boost_1_${VERSION}_0/ \
#  \
#    && ./bootstrap.sh --prefix=$FREECAD \
#    && ./b2 -j$(nproc) install

### libMED 3.0.6
#----------------
RUN apt-get install -y \
		libmed-dev \
		libmedc-dev
### libMED 3.2.0
#-------------
#RUN \
#    cd \
#    && mkdir med \
#    && cd med \
#    && git clone https://github.com/luvres/libMED.git \
#  \
#  # building MED
#    && mkdir build \
#    && cd build \
#  \
#    && cmake ../libMED \
#        -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
#  \
#    && make -j$(nproc) \
#    && make install

### libCoin 3.1.4
#-----------------
RUN apt-get install -y \
		libcoin80 \
		libcoin80-dev 

### Eigen 3.2.2 - 3.3.0(backports)
#----------------------------------
RUN apt-get install -y \
  	  libeigen3-dev 
### Eigen 3.3.4
#---------------
# http://eigen.tuxfamily.org/index.php?title=Main_Page
#RUN \
#	eigen_VERSION=3.3.4 && \
#  \
#    cd \
#    && mkdir eigen \
#    && cd eigen \
#    && wget -c http://bitbucket.org/eigen/eigen/get/${eigen_VERSION}.tar.gz \
#	&& tar zxf ${eigen_VERSION}.tar.gz \
#	&& rm ${eigen_VERSION}.tar.gz \
#	&& mv eigen-* eigen-${eigen_VERSION} \
#	&& mkdir build \
#    && cd build \
#  \
#    && cmake ../eigen-${eigen_VERSION} \
#        -DCMAKE_INSTALL_PREFIX=$FREECAD \
#        -DCMAKE_C_FLAGS_RELEASE=-DNDEBUG \
#        -DCMAKE_CXX_FLAGS_RELEASE=-DNDEBUG \
#        -DCMAKE_BUILD_TYPE=Release \
#        -DCMAKE_VERBOSE_MAKEFILE=ON \
#  \
#    && make install

### OCCT 7.1.0
#-------------
RUN \
	apt-get install -y \
		libfreeimage-dev \
		libtbb-dev \
	&& \
    MAKEDIR=occt && \
    cd \
    && mkdir $MAKEDIR \
    && cd $MAKEDIR \
    && git clone https://github.com/luvres/occt7.git \
    && mkdir build \
    && cd build \
  \
    && cmake \
		../occt7 \
		-DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
		-DUSE_VTK:BOOL=OFF \
		-DUSE_TBB:BOOL=ON \
		-DUSE_FREEIMAGE:BOOL=ON \
		-DCMAKE_BUILD_TYPE=Release \
  \
    && make -j$(nproc) \
    && make install


### VTK 7.1.1
#-------------
# 8.0.0
RUN \
	vtk_VERSION_MAJOR=7.1 && \
	vtk_VERSION_MINOR=7.1.1 && \
	\
	cd \
	&& mkdir vtk \
	&& cd vtk \
	&& wget http://www.vtk.org/files/release/${vtk_VERSION_MAJOR}/VTK-${vtk_VERSION_MINOR}.tar.gz \
	&& gunzip VTK-${vtk_VERSION_MINOR}.tar.gz \
	&& tar xf VTK-${vtk_VERSION_MINOR}.tar \
	&& rm VTK-${vtk_VERSION_MINOR}.tar \
  # building VTK
	&& mkdir build \
	&& cd build \
  \
	&& cmake ../VTK-${vtk_VERSION_MINOR} \
			-DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
			-DVTK_Group_Rendering:BOOL=OFF \
			-DVTK_Group_StandAlone:BOOL=ON \
			-DVTK_RENDERING_BACKEND=None \
  \
	&& make -j$(nproc) \
	&& make install
#
### VTK (Git)
#-------------
#RUN \
#    cd \
#    && mkdir vtk \
#    && cd vtk \
#    && git clone https://gitlab.kitware.com/vtk/vtk.git \
#  # building VTK
#    && mkdir build \
#    && cd build \
#  \
#    && cmake ../vtk \
#            -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD \
#            -DVTK_Group_Rendering:BOOL=OFF \
#            -DVTK_Group_StandAlone:BOOL=ON \
#            -DVTK_RENDERING_BACKEND=None \
#  \
#    && make -j$(nproc) \
#    && make install


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
#    && dpkg -i netgen_${netgen_VERSION}-jessie_amd64.deb \
#    && rm netgen_${netgen_VERSION}-jessie_amd64.deb
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



git clone https://github.com/luvres/FreeCAD-0.16.6712.git
mkdir freecad-build && cd freecad-build

cmake \
../FreeCAD-0.16.6712 \
-DBUILD_FEM_NETGEN=ON \
-DCMAKE_INSTALL_PREFIX="/usr/lib/freecad"

time make -j$(nproc)


### FreeCAD latest Github commit
#--------------------------------
# get FreeCAD
#RUN \
#    cd \
#    && git clone https://github.com/FreeCAD/FreeCAD 
RUN \
    cd \
	&& wget -c http://pi/FreeCAD/packages/master.tar.gz \
	&& tar zxf master.tar.gz \
	&& rm master.tar.gz

# building FreeCAD
RUN \
    cd \
    && mkdir build \
    && cd build \
  \
    && cmake ../FreeCAD \
            -DCMAKE_INSTALL_PREFIX:PATH=/usr \
            -DBUILD_FEM_NETGEN=ON \
            -DOCC_INCLUDE_DIR=/usr/include/opencascade 
            #-DNETGEN_ROOT=/usr/share/netgen 
            #-DCMAKE_CXX_FLAGS="-DNETGEN_V5" 
            #-DFREECAD_USE_OCC_VARIANT="Official Version"  
            #-DOCC_LIBRARY=/usr/lib/libTKernel.so 
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

