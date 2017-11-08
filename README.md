# hyperterm-hardware [![Build Status](https://travis-ci.org/mikeanthonywild/hyperterm-hardware.svg?branch=master)](https://travis-ci.org/mikeanthonywild/hyperterm-hardware)

An open-source laptop with maintainability and sustainability in mind.
This repo contains hardware components (schematics, PCBs, SPICE models, simulations etc.).

## Getting Started

Before you can build this project, you'll need [Git](https://git-scm.com/) and [Docker](https://www.docker.com/) installed. If you're on Windows you'll need something for running GNU Makefiles such as [WSL](https://msdn.microsoft.com/en-us/commandline/wsl/about) or [MinGW](http://mingw.org/).

```shell
# Clone the project
$ git clone git@github.com:mikeanthonywild/hyperterm-hardware.git
$ cd hyperterm-hardware

# Start a socat listener for X11-forwarding (macOS-only)
$ socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &

# Build and enter the development environment
# CTRL+D exits the shell
$ make shell

# Verify everything is working
$ make test
```

Once inside the shell, you'll have access to all of the development tools such as KiCad and PySpice. X11-forwarding is enabled in the Docker container, so any GUI apps will behave as expected.
