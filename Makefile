.PHONY: help all build shell

DOCKER_IMAGE := hyperterm-hardware-dev

# Some special setup is required for X11 forwarding on Mac
HOST_IP := $(shell ifconfig en0 | grep inet | awk '$$1=="inet" {print $$2}')
X11_DISPLAY := $(HOST_IP)$(shell ps -ef | grep "Xquartz :\d" | grep -v xinit | awk '{ print $$9; }')

help:
	@echo "make shell - Enter development environment"

build: Dockerfile
	$(warning First-time environment setup could take a while...)
	docker build -t $(DOCKER_IMAGE) .

shell: build
	# MacOS seems to require socat for X11 forwarding to work...
	@nc -z localhost 6000; if [ ! $$? -eq 0 ]; then echo "Nothing listening on port 6000 - socat must be running for X11 forwarding (check README)" && exit 1; fi
	xhost + $(HOST_IP) && docker run --rm -i -v $(CURDIR):/data -e DISPLAY=$(X11_DISPLAY) -v /tmp/.X11-unix:/tmp/.X11-unix -t $(DOCKER_IMAGE) bash

all: build
