## FreeCAD
### FEM Module with Netgen and Calculix
### Docker image for any Linux
### NVIDIA Docker and VirtualGL
-----

#### FreeCAD Latest - Build: 0.17R11659 (Git)
#### FEM - Netgen, Gmsh and Calculix 2.12
##### Pull image
```
docker pull izone/freecad
```
```
```
##### Run
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad freecad-git
```
```
```
#### FreeCAD Stable (0.16)
##### Pull image
```
docker pull izone/freecad:stable
docker pull izone/freecad:0.16
```
```
```
##### Run
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:stable freecad
```
```
```
#### FreeCAD Daily (0.17)
##### Pull image
```
docker pull izone/freecad:daily
docker pull izone/freecad:0.17
```
```
```
##### Run
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:daily freecad-daily
```
```
```
-----
#### NVIDIA Docker (https://github.com/NVIDIA/nvidia-docker)
```
# Install nvidia-docker and nvidia-docker-plugin
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1_amd64.tar.xz
sudo tar --strip-components=1 -C /usr/bin -xvf /tmp/nvidia-docker*.tar.xz && rm /tmp/nvidia-docker*.tar.xz

# Run nvidia-docker-plugin
sudo -b nohup nvidia-docker-plugin > /tmp/nvidia-docker.log

# Test nvidia-smi
nvidia-docker run --rm nvidia/cuda nvidia-smi
```
```
```
#### FreeCAD Latest (Build 0.17 Git)
```
nvidia-docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad freecad-git
```
```
```
#### FreeCAD Stable (0.16)
```
nvidia-docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:stable freecad
```
```
```
#### FreeCAD Daily (0.17)
```
nvidia-docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:daily freecad-daily
```

```
```
-----
#### Building (https://hub.docker.com/r/plumbee/nvidia-virtualgl/)
```
git clone https://github.com/luvres/freecad.git
cd freecad
```
```
```
```
docker build -t izone/freecad:nvidia ./nvidia/
docker build -t izone/freecad:nvidia-trusty ./nvidia/trusty/
docker build -t izone/freecad:nvidia-sid ./nvidia/sid/
docker build -t izone/freecad:nvidia-stretch ./nvidia/stretch/
docker build -t izone/freecad:nvidia-jessie ./nvidia/jessie/
```
```
```
#### FreeCAD Latest (0.17 Git)
```
docker build -t izone/freecad .
```
```
```
#### FreeCAD Stable (0.16)
```
docker build -t izone/freecad:stable ./0.16/
docker build -t izone/freecad:0.16 ./0.16/
```
```
```
#### FreeCAD Daily (0.17)
```
docker build -t izone/freecad:daily ./0.17/
docker build -t izone/freecad:0.17 ./0.17/
```
