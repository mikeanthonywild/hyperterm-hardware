FROM ubuntu:17.04
MAINTAINER Mike Wild <mike@mikeanthonywild.com>

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV LANGUAGE=C.UTF-8

RUN apt-get update -y && apt-get install -y \
    software-properties-common

# Ensure 'update' and 'install' are on same line so Docker
# invalidates the cache when we add a new package.
RUN add-apt-repository ppa:js-reynaud/kicad-4
RUN apt-get update -y && \
    apt-get install -y \
        kicad=4.0.7+e2-6376~58~ubuntu17.04.1 \
        ngspice=26-1.1 \
        python3=3.5.3-1 \
        python3-pip=9.0.1-2 \
        && \
    pip3 install \
        PySpice==1.1.3 \
        PyYAML==3.12 \
        cffi==1.11.2 \
        matplotlib==2.1.0 \
        numpy==1.13.3 \
        scipy==1.0.0

# Drop the user into project directory
WORKDIR /workspace
