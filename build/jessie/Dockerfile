FROM freecad:jessie-base
MAINTAINER Leonardo Loures <luvres@hotmail.com>

### FreeCAD latest Github commit
#--------------------------------
RUN \
    cd \
    && git clone https://github.com/FreeCAD/FreeCAD \
  # To get all materials ?
    #&& sed -i '/GLOB MaterialLib_Files/s/#//' FreeCAD/src/Mod/Material/CMakeLists.txt 
  # building FreeCAD
    && mkdir build \
    && cd build \
  \
  # with oce-dev installed, with netgen
    && cmake ../FreeCAD  \
            -DCMAKE_INSTALL_PREFIX:PATH=$FREECAD  \
            -DBUILD_FEM_NETGEN=1  \
            -DCMAKE_CXX_FLAGS="-DNETGEN_V5"  \
            -DNETGEN_ROOT=$FREECAD  \
            -DFREECAD_USE_OCC_VARIANT="Official Version"  \
            -DOCC_INCLUDE_DIR=$FREECAD/include/opencascade  \
            -DOCC_LIBRARY=$FREECAD/lib/libTKernel.so \
            -DEIGEN3_INCLUDE_DIR=$FREECAD/include/eigen3 \
  \
    && make -j$(nproc) 
#    #&& make install
# 
# # start FreeCAD
# # $FREECAD/bin/FreeCAD

