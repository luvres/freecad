# FreeCAD with Netgen and Calculix
## In Docker image for any Linux
## NVIDIA Docker and VirtualGL
-----
### FreeCAD 0.17
```
docker pull izone/freecad:0.17
```
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:0.17 freecad-daily
```
### FreeCAD 0.16
```
docker pull izone/freecad:0.16
```
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:0.16 freecad
```


### NVIDIA Docker (https://github.com/NVIDIA/nvidia-docker)
-----
```
# Install nvidia-docker and nvidia-docker-plugin
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1_amd64.tar.xz
sudo tar --strip-components=1 -C /usr/bin -xvf /tmp/nvidia-docker*.tar.xz && rm /tmp/nvidia-docker*.tar.xz

# Run nvidia-docker-plugin
sudo -b nohup nvidia-docker-plugin > /tmp/nvidia-docker.log

# Test nvidia-smi
nvidia-docker run --rm nvidia/cuda nvidia-smi
```

##### FreeCAD 0.17
```
nvidia-docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:0.17 freecad-daily
```
##### FreeCAD 0.16
```
nvidia-docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:0.16 freecad
```


### Building
```
docker build -t izone/freecad:nvidia ./nvidia/
```
```
git clone https://github.com/luvres/freecad.git
cd freecad
```
##### FreeCAD 0.17
```
docker build -t izone/freecad:0.17 ./0.17/
```
##### FreeCAD 0.16
```
docker build -t izone/freecad:0.16 ./0.16/
```
