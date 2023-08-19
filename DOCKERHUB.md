# Docker container for PuTTY
[![Release](https://img.shields.io/github/release/jlesage/docker-putty.svg?logo=github&style=for-the-badge)](https://github.com/jlesage/docker-putty/releases/latest)
[![Docker Image Size](https://img.shields.io/docker/image-size/jlesage/putty/latest?logo=docker&style=for-the-badge)](https://hub.docker.com/r/jlesage/putty/tags)
[![Docker Pulls](https://img.shields.io/docker/pulls/jlesage/putty?label=Pulls&logo=docker&style=for-the-badge)](https://hub.docker.com/r/jlesage/putty)
[![Docker Stars](https://img.shields.io/docker/stars/jlesage/putty?label=Stars&logo=docker&style=for-the-badge)](https://hub.docker.com/r/jlesage/putty)
[![Build Status](https://img.shields.io/github/actions/workflow/status/jlesage/docker-putty/build-image.yml?logo=github&branch=master&style=for-the-badge)](https://github.com/jlesage/docker-putty/actions/workflows/build-image.yml)
[![Source](https://img.shields.io/badge/Source-GitHub-blue?logo=github&style=for-the-badge)](https://github.com/jlesage/docker-putty)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg?style=for-the-badge)](https://paypal.me/JocelynLeSage)

This is a Docker container for [PuTTY](https://www.putty.org).

The GUI of the application is accessed through a modern web browser (no
installation or configuration needed on the client side) or via any VNC client.

---

[![PuTTY logo](https://images.weserv.nl/?url=raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/putty-icon.png&w=110)](https://www.putty.org)[![PuTTY](https://images.placeholders.dev/?width=160&height=110&fontFamily=monospace&fontWeight=400&fontSize=52&text=PuTTY&bgColor=rgba(0,0,0,0.0)&textColor=rgba(121,121,121,1))](https://www.putty.org)

PuTTY is a free and open-source terminal emulator, serial console and network file
transfer application. It supports several network protocols, including SCP, SSH,
Telnet, rlogin, and raw socket connection. It can also connect to a serial port.

---

## Quick Start

**NOTE**:
    The Docker command provided in this quick start is given as an example
    and parameters should be adjusted to your need.

Launch the PuTTY docker container with the following command:
```shell
docker run -d \
    --name=putty \
    -p 5800:5800 \
    -v /docker/appdata/putty:/config:rw \
    jlesage/putty
```

Where:

  - `/docker/appdata/putty`: This is where the application stores its configuration, states, log and any files needing persistency.

Browse to `http://your-host-ip:5800` to access the PuTTY GUI.

## Documentation

Full documentation is available at https://github.com/jlesage/docker-putty.

## Support or Contact

Having troubles with the container or have questions?  Please
[create a new issue].

For other great Dockerized applications, see https://jlesage.github.io/docker-apps.

[create a new issue]: https://github.com/jlesage/docker-putty/issues
