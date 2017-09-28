FROM ubuntu:17.04
MAINTAINER Mike Wild <mike@mikeanthonywild.com>

# Required for adding PPAs
RUN apt-get update -y && apt-get install software-properties-common -y

RUN add-apt-repository ppa:js-reynaud/kicad-4
RUN apt-get update -y && apt-get install -y kicad

# Drop the user into project directory
WORKDIR /data
