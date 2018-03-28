FROM ubuntu:17.10
LABEL name="hyperterm-hardware" \
      version="0.1.0"
MAINTAINER Mike Wild <mike@mikeanthonywild.com>

# Required to get Python working
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV LANGUAGE=C.UTF-8

# Installing KiCad from PPA times out build for some reason.
# Disable this and install from Ubuntu repos for time being...
#RUN add-apt-repository ppa:js-reynaud/kicad-4
#kicad=4.0.7+e2-6376~58~ubuntu17.04.1 \

# Ensure 'update' and 'install' are on same line so Docker
# invalidates the cache when we add a new package.
RUN apt-get update -y && \
    apt-get install -y \
        wget=1.19.1-3ubuntu1.1 \
        kicad=4.0.6+dfsg1-1 \
        python3=3.6.3-0ubuntu2 \
        python3-pip=9.0.1-2 \
        python3-tk=3.6.3-0ubuntu1 \
        nodejs=6.11.4~dfsg-1ubuntu1 \
        npm=3.5.2-0ubuntu4 \
        ruby-full=1:2.3.3 \
    && \
    pip3 install \
        PyTest==3.2.5 \
        PySpice==1.1.3 \
        Sphinx==1.6.5 \
        Flake8==3.5.0 \
    && \
    npm install -g \
        dockerfile_lint@0.2.7 \
    && \
    gem install --no-rdoc --no-ri \
        travis:1.8.8 \
    && \
    # Cleanup
    rm -rf ~/.cache/pip/* && gem cleanup && apt-get clean

# Pushing out a new release for 17:10 via Launchpad is too
# time consuming, so just isntall straight from the .deb...
RUN wget https://launchpad.net/~mikewild/+archive/ubuntu/ngspice-shared/+build/13749894/+files/ngspice_26-1.1ubuntu4_amd64.deb && \
    dpkg -i ngspice_26-1.1ubuntu4_amd64.deb

# Drop the user into project directory
WORKDIR /workspace
