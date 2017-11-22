DOCKER_IMAGE := hyperterm-hardware-dev

# Run make with -j2 on Travis
CI_NUM_JOBS := 2

# Some special setup is required for X11 forwarding on Mac
HOST_IP = $(shell ifconfig en0 | grep inet | awk '$$1=="inet" {print $$2}')
X11_DISPLAY = $(HOST_IP)$(shell ps -ef | grep "Xquartz :\d" | grep -v xinit | awk '{ print $$9; }')

BUILD_DIR ?= ./build
SCHEM_DIR := ./schematics
SIM_DIR := ./sims

SCHEMS := $(wildcard $(SCHEM_DIR)/*.sch)
NETLISTS := $(patsubst $(SCHEM_DIR)/%.sch, $(BUILD_DIR)/%.cir, $(SCHEMS))

.PHONY: help
help:
	@echo "make shell       - Enter development environment"
	@echo "make test        - Run automated tests"
	@echo "make docs        - Make documentation"

.PHONY: build
build: Dockerfile
	$(warning First-time environment setup could take a while...)
	docker build -t $(DOCKER_IMAGE) .

.PHONY: shell
shell: build
	# macOS seems to require socat for X11 forwarding to work...
	@nc -z localhost 6000; if [ ! $$? -eq 0 ]; then echo "Nothing listening on port 6000 - socat must be running for X11 forwarding (check README)" && exit 1; fi
	@echo "Entering development shell - press CTRL+D to exit..."
	xhost + $(HOST_IP) && docker run --rm -i -v $(CURDIR):/workspace -e DISPLAY=$(X11_DISPLAY) -v /tmp/.X11-unix:/tmp/.X11-unix -t $(DOCKER_IMAGE) bash

$(BUILD_DIR):
	mkdir -p $(dir $@)

$(BUILD_DIR)/%.cir: $(SCHEM_DIR)/%.sch | $(BUILD_DIR)
	@echo "Need to build $@ from $<"

.PHONY: test
test: $(NETLISTS)
	pytest sims

.PHONY: docs
docs:
	# Extra-strict -W converts warnings to errors
	sphinx-build -W -b html docs docs/_build/html

# Do we always need to build this from scratch?
# Figure out if we can pick up pre-built image to speed things up.
.PHONY: docker-test
docker-test: build
	# There's no need to mount the workspace - it should be
	# part of the build.
	docker run -v $(CURDIR):/workspace -t $(DOCKER_IMAGE) bash -c "make -j$(CI_NUM_JOBS) test"

.PHONY: docker-docs
docker-docs: build
	# There's no need to mount the workspace - it should be
	# part of the build.
	docker run -v $(CURDIR):/workspace -t $(DOCKER_IMAGE) bash -c "make -j$(CI_NUM_JOBS) docs"


.PHONY: all
all: test
