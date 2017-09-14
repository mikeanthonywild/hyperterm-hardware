.PHONY: help all build shell

DOCKER_IMAGE := hyperterm-hardware-dev

help:
	@echo "make shell - Enter development environment"

build: Dockerfile
	$(warning First-time environment setup could take a while...)
	docker build -t $(DOCKER_IMAGE) .

shell: build
	docker run --rm -i -v $(CURDIR):/data -t $(DOCKER_IMAGE) bash

all: build
