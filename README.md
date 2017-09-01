## FreeCAD amd64 and armhf
### FEM Module with Netgen, Gmsh and Calculix
### Docker image for any Linux
### NVIDIA Docker and VirtualGL
-----
#### FreeCAD Latest - Build:0.17R11949 (Git commit 5d2b22c)
#### libMED 3.2.0
#### OCCT 7.1.0p1
#### Netgen 5.3.1
#### VTK 8.0.0
#### CalculiX 2.12
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
-----
#### Building (https://hub.docker.com/r/plumbee/nvidia-virtualgl/)
```
git clone https://github.com/luvres/freecad.git
```
```
cd freecad
```
```
docker build -t izone/freecad:nvidia-xenial ./nvidia/ && \
```
```
docker build -t izone/freecad:nvidia-jessie ./nvidia/jessie/ && \
```
```
docker build -t izone/freecad:nvidia-stretch ./nvidia/stretch/ && \
```
```
docker build -t izone/freecad:nvidia-sid ./nvidia/sid/
```
```
```
#### FreeCAD Latest (0.17 Git)
```
docker build -t izone/freecad .
```
```
docker build -t izone/freecad:0.17R11949 .
```
```
```
#### FreeCAD Stable (0.16)
```
docker build -t izone/freecad:stable ./stable/
```
```
```
-----
### Raspberry Pi 3 (armhf)
##### Pull image
```
docker pull izone/freecad:armhf
```
##### Run in Raspberry Pi
```
docker pull izone/freecad:armhf
```
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:armhf freecad
```
```
```
### Docker QEMU (armhf in amd64)
#### Run 
```
sudo apt-get install qemu-user-static
```
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:armhf freecad
```
```
```
#### Build
```
sudo apt-get install qemu-user-static binfmt-support
```
```
sudo update-binfmts --enable qemu-arm
```
```
sudo update-binfmts --display qemu-arm 
```
```
cp /usr/bin/qemu-arm-static .
```
```
docker build -t izone/freecad:armhf ./armhf/
```
-----
##### Save image
```
docker save izone/freecad:armhf > img-freecad-armhf.tar
```
##### Load Image
```
docker load < img-freecad-armhf.tar
```
