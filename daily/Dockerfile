FROM izone/freecad:nvidia-xenial
MAINTAINER Leonardo Loures <luvres@hotmail.com>

RUN apt-get update \
  \
    && apt-get install -y --no-install-recommends software-properties-common \
    && add-apt-repository -y ppa:freecad-maintainers/freecad-daily \
    && apt-get update \
    && apt-get install -y freecad-daily netgen gmsh \
  \
    && apt-get clean \
    && rm /var/lib/apt/lists/* \
          /usr/share/doc/* \
          /usr/share/locale/* \
          /usr/share/man/* \
          /usr/share/info/* -fR
