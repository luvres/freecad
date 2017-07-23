FROM izone/freecad:nvidia
MAINTAINER Leonardo Loures <luvres@hotmail.com>

RUN apt update \
  \
    && apt install -y --no-install-recommends software-properties-common \    
    && add-apt-repository -y ppa:freecad-maintainers/freecad-daily \
    && apt update \
    && apt install -y \
  \
    freecad-daily \
  \
    && apt clean \
    && rm /var/lib/apt/lists/* \
          /usr/share/doc/* \
          usr/share/locale/* \
          usr/share/man/* \
          usr/share/info/* -fR
