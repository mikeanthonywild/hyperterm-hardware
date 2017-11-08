FROM ubuntu:17.04
MAINTAINER Mike Wild <mike@mikeanthonywild.com>

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV LANGUAGE=C.UTF-8

# Installing KiCad from PPA times out build for some reason.
# Disable this and install from Ubuntu repos for time being...
#RUN apt-get update -y && apt-get install -y \
#    software-properties-common
#RUN add-apt-repository ppa:js-reynaud/kicad-4
#kicad=4.0.7+e2-6376~58~ubuntu17.04.1 \

# Ensure 'update' and 'install' are on same line so Docker
# invalidates the cache when we add a new package.
RUN apt-get update -y && \
    apt-get install -y \
        python3=3.5.3-1 \
        python3-pip=9.0.1-2 \
        python3-tk=3.5.3-1ubuntu1 \
        && \
    pip3 install \
        PySpice==1.1.3 \
        PyYAML==3.12 \
        cffi==1.11.2 \
        matplotlib==2.1.0 \
        numpy==1.13.3 \
        scipy==1.0.0

# The ngspice in the Ubuntu repos doesn't include the shared lib so
# we'll build from source for the time being
#ngspice=26-1.1 && \
RUN apt-get install -y \
        libreadline-dev=7.0-0ubuntu2 \
        curl=7.52.1-4ubuntu1.3 \
    curl -L https://sourceforge.net/projects/ngspice/files/ng-spice-rework/27/ngspice-27.tar.gz/download | tar xv && \
    cd ngspice-27 && \
    ./configure --prefix=/usr/local \
                --enable-xspice \
                --disable-debug \
                --enable-cider \
                --with-readline=yes \
                --enable-openmp \
                --with-ngshared && \
    make && \
    make install && \
    apt-get install -y kicad=4.0.5+dfsg1-4 

# Drop the user into project directory
WORKDIR /workspace
