.PHONY: help all build shell

DOCKER_IMAGE := hyperterm-hardware-dev

# Some special setup is required for X11 forwarding on Mac
HOST_IP = $(shell ifconfig en0 | grep inet | awk '$$1=="inet" {print $$2}')
X11_DISPLAY = $(HOST_IP)$(shell ps -ef | grep "Xquartz :\d" | grep -v xinit | awk '{ print $$9; }')

.PHONY: help
help:
	@echo "make shell - Enter development environment"
	@echo "make test  - Run automated tests"

.PHONY: build
build: Dockerfile
	$(warning First-time environment setup could take a while...)
	docker build -t $(DOCKER_IMAGE) .

.PHONY: shell
shell: build
	# macOS seems to require socat for X11 forwarding to work...
	@nc -z localhost 6000; if [ ! $$? -eq 0 ]; then echo "Nothing listening on port 6000 - socat must be running for X11 forwarding (check README)" && exit 1; fi
	xhost + $(HOST_IP) && docker run --rm -i -v $(CURDIR):/workspace -e DISPLAY=$(X11_DISPLAY) -v /tmp/.X11-unix:/tmp/.X11-unix -t $(DOCKER_IMAGE) bash

.PHONY: test
test:
	@echo "Nothing to test..."

# Do we always need to build this from scratch?
# Figure out if we can pick up pre-built image to speed things up.
.PHONY: docker-test
docker-test: build
	@echo "Entering development shell - press CTRL+D to exit..."
	# There's no need to mount the workspace - it should be
	# part of the build.
	docker run -v $(CURDIR):/workspace -t $(DOCKER_IMAGE) bash -c "make test"

.PHONY: all
all: test
