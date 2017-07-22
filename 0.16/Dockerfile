FROM izone/freecad:nvidia
MAINTAINER Leonardo Loures <luvres@hotmail.com>

RUN apt update \
  \
    && apt install -y software-properties-common \
    && add-apt-repository -y ppa:freecad-maintainers/freecad-stable \
    && apt update \
    && apt install -y \
  \
    freecad
