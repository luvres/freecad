## FreeCAD amd64, armhf and aarch64
### FEM Module with Netgen, Gmsh and Calculix
### Docker image for any Linux
### NVIDIA Docker and VirtualGL
-----
#### FreeCAD Git - Build:0.18R14446 (Git)
#### libMED 3.2.0
#### OCCT 7.1.0p1
#### Netgen 5.3.1
#### Eigen 3.3.5
#### VTK 8.1.1
#### CalculiX 2.14
##### Pull image
```
docker pull izone/freecad
```
```
```
##### Run
```
mkdir $HOME/freecad-workspace
```
```
```
#### FreeCAD Daily (0.18)
##### Pull image
```
docker pull izone/freecad:daily
```
```
```
```
docker run -ti --rm --name FreeCAD \
--net=host \
--device /dev/dri \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
-v $HOME/freecad-workspace:/mnt \
-w /mnt \
izone/freecad:daily freecad-daily
```
```
```
#### FreeCAD Stable (0.17)
##### Pull image
```
docker pull izone/freecad:stable
```
```
```
```
docker run -ti --rm --name FreeCAD \
--net=host \
--device /dev/dri \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
-v $HOME/freecad-workspace:/mnt \
-w /mnt \
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
#### FreeCAD Latest (Build 0.18 Git)
```
mkdir $HOME/freecad-workspace
```
```
```
```
nvidia-docker run -ti --rm --name FreeCAD \
--net=host \
--device /dev/dri \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
-v $HOME/freecad-workspace:/mnt \
-w /mnt \
izone/freecad freecad-git
```
```
```
-----
#### FreeCAD-addons (https://github.com/FreeCAD/FreeCAD-addons)
##### Some:
```
mkdir $HOME/Mod
```
```
git clone https://github.com/hamish2014/FreeCAD_assembly2.git $HOME/Mod/Assembly2
```
```
git clone https://github.com/microelly2/Animation.git $HOME/Mod/Animation
```
```
git clone https://github.com/DeepSOIC/Lattice2.git $HOME/Mod/Lattice2
```
```
git clone https://github.com/JMG1/FreeCAD_ExplodedAssemblyAnimationWorkbench.git $HOME/Mod/Exploded
```
```
```
##### Run
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
--device /dev/dri \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
-v $HOME/Mod/Assembly2:$FREECAD/Mod/Assembly2 \
-v $HOME/Mod/Animation:$FREECAD/Mod/Animation \
-v $HOME/Mod/Lattice2:$FREECAD/Mod/Lattice2 \
-v $HOME/Mod/Exploded:$FREECAD/Mod/Exploded \
-v $HOME/freecad-workspace:/mnt \
-w /mnt \
izone/freecad freecad-git
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
docker build -t izone/freecad:nvidia-xenial ./nvidia/xenial/ && \
docker build -t izone/freecad:nvidia-xenial-slim ./nvidia/xenial-slim/ && \
docker build -t izone/freecad:nvidia-jessie ./nvidia/jessie/ && \
docker build -t izone/freecad:nvidia-stretch ./nvidia/stretch/ && \
docker build -t izone/freecad:nvidia-sid ./nvidia/sid/
```
```
```
#### FreeCAD Git (0.18)
```
docker build -t izone/freecad .
```
```
```
#### FreeCAD Latest (0.18 Daily)
```
docker build -t izone/freecad:daily ./daily/
```
```
```
#### FreeCAD Stable (0.16)
```
docker build -t izone/freecad:stable ./stable/
```
```
```
##### Jessie
```
docker build -t izone/freecad:jessie ./jessie/
```
```
```
-----
### Raspberry Pi 3
#### armhf
##### Pull image
```
docker pull izone/freecad:armhf
```
##### Run in Raspberry Pi
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:armhf freecad-git
```
```
```
#### aarch64
##### Pull image
```
docker pull izone/freecad:aarch64
```
##### Run in Raspberry Pi
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:aarch64 freecad-git
```
```
```
### Docker QEMU
#### armhf in amd64
```
sudo apt-get install qemu-user-static
```
#### Run
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:armhf freecad-git
```
#### Build
```
sudo apt-get install qemu-user-static binfmt-support
sudo update-binfmts --enable qemu-arm
sudo update-binfmts --display qemu-arm 
cp /usr/bin/qemu-arm-static .
```
```
```
```
docker build -t izone/freecad:armhf ./armhf/
```
```
```
#### aarch64 in amd64
```
sudo apt-get install qemu-aarch64-static
```
#### Run
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /usr/bin/qemu-aarch64-static:/usr/bin/qemu-aarch64-static \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:aarch64 freecad-git
```
#### Build
```
sudo apt-get install qemu-user-static binfmt-support
sudo update-binfmts --enable qemu-arm
sudo update-binfmts --display qemu-arm 
cp /usr/bin/qemu-aarch64-static .
```
```
```
```
docker build -t izone/freecad:aarch64 ./aarch64/
```

-----
#### Save image
```
docker save izone/freecad:armhf > img-freecad-armhf.tar
```
```
docker save izone/freecad:aarch64 > img-freecad-aarch64.tar
```
#### Load Image
```
docker load < img-freecad-armhf.tar
```
```
docker load < img-freecad-aarch64.tar
```
