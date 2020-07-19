# Docker container for PuTTY
[![Docker Image Size](https://img.shields.io/microbadger/image-size/jlesage/putty)](http://microbadger.com/#/images/jlesage/putty) [![Build Status](https://drone.le-sage.com/api/badges/jlesage/docker-putty/status.svg)](https://drone.le-sage.com/jlesage/docker-putty) [![GitHub Release](https://img.shields.io/github/release/jlesage/docker-putty.svg)](https://github.com/jlesage/docker-putty/releases/latest) [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://paypal.me/JocelynLeSage/0usd)

This is a Docker container for [PuTTY](https://www.putty.org).

The GUI of the application is accessed through a modern web browser (no installation or configuration needed on the client side) or via any VNC client.

---

[![PuTTY logo](https://images.weserv.nl/?url=raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/putty-icon.png&w=200)](https://www.putty.org)[![PuTTY](https://dummyimage.com/400x110/ffffff/575757&text=PuTTY)](https://www.putty.org)

PuTTY is a free and open-source terminal emulator, serial console and network file transfer application. It supports several network protocols, including SCP, SSH, Telnet, rlogin, and raw socket connection. It can also connect to a serial port.

---

## Quick Start

**NOTE**: The Docker command provided in this quick start is given as an example
and parameters should be adjusted to your need.

Launch the PuTTY docker container with the following command:
```
docker run -d \
    --name=putty \
    -p 5800:5800 \
    -v /docker/appdata/putty:/config:rw \
    jlesage/putty
```

Where:
  - `/docker/appdata/putty`: This is where the application stores its configuration, log and any files needing persistency.

Browse to `http://your-host-ip:5800` to access the PuTTY GUI.

## Documentation

Full documentation is available at https://github.com/jlesage/docker-putty.

## Support or Contact

Having troubles with the container or have questions?  Please
[create a new issue].

For other great Dockerized applications, see https://jlesage.github.io/docker-apps.

[create a new issue]: https://github.com/jlesage/docker-putty/issues
