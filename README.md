## FreeCAD with Netgen and Calculix in Docker image
-----
### FreeCAD 0.17
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
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:0.16 freecad
```

##### Building
```


docker build -t izone/freecad:0.16 ./0.16/

### Runing
```
docker run -ti --rm --name FreeCAD \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
izone/freecad:daily freecad-daily
```
