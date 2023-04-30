#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

# Set same default compilation flags as abuild.
export CFLAGS="-Os -fomit-frame-pointer"
export CXXFLAGS="$CFLAGS"
export CPPFLAGS="$CFLAGS"
export LDFLAGS="-Wl,--strip-all -Wl,--as-needed"

export CC=xx-clang
export CXX=xx-clang++

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

function log {
    echo ">>> $*"
}

PUTTY_URL="$1"

if [ -z "$PUTTY_URL" ]; then
    log "ERROR: PuTTY URL missing."
    exit 1
fi

#
# Install required packages.
#
apk --no-cache add \
    curl \
    patch \
    binutils \
    clang \
    make \
    cmake \
    pkgconf \
    perl \

xx-apk --no-cache --no-scripts add \
    musl-dev \
    gcc \
    g++ \
    gtk+3.0-dev \

#
# Download sources.
#

log "Downloading PuTTY package..."
mkdir /tmp/putty
curl -# -L -f ${PUTTY_URL} | tar xz --strip 1 -C /tmp/putty

#
# Compile PuTTY
#

log "Configuring PuTTY..."
(
    mkdir /tmp/putty/build && \
    cd /tmp/putty/build && \
    # shared-mime-info.pc is installed under /usr/share/pkgconfig.
    PKG_CONFIG_PATH=/$(xx-info)/usr/share/pkgconfig cmake \
        $(xx-clang --print-cmake-defines) \
        -DCMAKE_FIND_ROOT_PATH=$(xx-info sysroot) \
        -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        ..
)

log "Patching PuTTY..."
find /tmp/putty
patch -d /tmp/putty -p1 < "$SCRIPT_DIR"/conf-window-position.patch
patch -d /tmp/putty -p1 < "$SCRIPT_DIR"/ctrl-right-menu.patch
patch -d /tmp/putty -p1 < "$SCRIPT_DIR"/restart-putty-button.patch

log "Compiling PuTTY..."
make -C /tmp/putty/build -j$(nproc)

log "Installing PuTTY..."
DESTDIR=/tmp/putty-install make -C /tmp/putty/build install
