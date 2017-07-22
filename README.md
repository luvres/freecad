### FreeCAD Stable
#------------------
tee Dockerfile <<EOF
FROM ubuntu:xenial
MAINTAINER Leonardo Loures <luvres@hotmail.com>

RUN apt update && apt upgrade -y \
  \
    && apt install -y software-properties-common \
    && add-apt-repository -y ppa:freecad-maintainers/freecad-stable \
    && apt update && apt install -y \
    freecad
EOF

docker build -t izone/freecad:stable .

### FreeCAD Daily
#------------------
tee Dockerfile <<EOF
FROM ubuntu:xenial
MAINTAINER Leonardo Loures <luvres@hotmail.com>

RUN apt update && apt upgrade -y \
  \
    && apt install -y software-properties-common \    
    && add-apt-repository -y ppa:freecad-maintainers/freecad-daily \
    && apt update && apt install -y \
    freecad-daily
EOF

docker build -t izone/freecad:daily .

### Runing
#----------
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad freecad

########################################
##############################
####################
