FROM ubuntu:17.04
LABEL name="hyperterm-hardware-dev" \
      version="0.1.0"
MAINTAINER Mike Wild <mike@mikeanthonywild.com>

# Required to get Python working
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV LANGUAGE=C.UTF-8

RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:mikewild/ngspice-shared
# Installing KiCad from PPA times out build for some reason.
# Disable this and install from Ubuntu repos for time being...
#RUN add-apt-repository ppa:js-reynaud/kicad-4
#kicad=4.0.7+e2-6376~58~ubuntu17.04.1 \

# Ensure 'update' and 'install' are on same line so Docker
# invalidates the cache when we add a new package.
RUN apt-get update -y && \
    apt-get install -y \
	ngspice=26-1.1ubuntu4 \
	kicad=4.0.5+dfsg1-4 \
        python3=3.5.3-1 \
        python3-pip=9.0.1-2 \
        python3-tk=3.5.3-1ubuntu1 \
	nodejs=4.7.2~dfsg-1ubuntu3 \
	npm=3.5.2-0ubuntu4 \
	ruby-full=1:2.3.3 \
        && \
    pip3 install \
	PyTest==3.2.5 \
        PySpice==1.1.3 \
        Sphinx==1.6.5 \
	Flake8==3.5.0 \
	# These are required since PySpice doesn't list its dependencies
	# https://github.com/FabriceSalvaire/PySpice/issues/84
	# TODO: Check for new release of PySpice
        PyYAML==3.12 \
        cffi==1.11.2 \
        matplotlib==2.1.0 \
        numpy==1.13.3 \
        scipy==1.0.0 \
	&& \
    npm install -g \
	dockerfile_lint@0.2.7 \
	&& \
    gem install --no-rdoc --no-ri \
	travis:1.8.8 \
	&& \
    # Cleanup
    rm -rf ~/.cache/pip/* && gem cleanup && apt-get clean

# Fix required to provide node bin
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Drop the user into project directory
WORKDIR /workspace
