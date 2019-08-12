#
# putty Dockerfile
#
# https://github.com/jlesage/docker-putty
#

# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.9-v3.5.2

# Define software versions.
ARG PUTTY_VERSION=0.72

# Define software download URLs.
ARG PUTTY_URL=https://the.earth.li/~sgtatham/putty/${PUTTY_VERSION}/putty-${PUTTY_VERSION}.tar.gz

# Define working directory.
WORKDIR /tmp

# Install PuTTY.
RUN \
    # Install packages needed by the build.
    add-pkg --virtual build-dependencies \
        build-base \
        curl \
        gtk+3.0-dev \
        && \

    # Download the PuTTY package.
    mkdir putty && \
    echo "Downloading PuTTY package..." && \
    curl -# -L ${PUTTY_URL} | tar xz --strip 1  -C putty && \

    # Compile PuTTY.
    cd putty && \
    ./configure \
        --prefix=/usr \
        && \
    make && make install && \
    strip /usr/bin/putty && \
    cd .. && \

    # Install PuTTY.
    cp -v putty/putty /usr/bin/ && \
    strip /usr/bin/putty && \

    # Cleanup.
    del-pkg build-dependencies && \
    rm -rf /tmp/* /tmp/.[!.]*

# Install dependencies.
RUN add-pkg \
        gtk+3.0

# Adjust the openbox config.
RUN \
    # Maximize only the main/initial window.
    sed-patch 's/<application type="normal">/<application type="normal" title="putty">/' \
        /etc/xdg/openbox/rc.xml  && \
    # Make sure popup windows are shown in the center.
    sed-patch '/<\/applications>/i\  <application title="PuTTY*">\n    <decor>no<\/decor>\n    <position force="no">\n      <x>center<\/x>\n      <y>center<\/y>\n    <\/position>\n  <\/application>' \
        /etc/xdg/openbox/rc.xml

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://github.com/jlesage/docker-templates/raw/master/jlesage/images/putty-icon.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /

# Set environment variables.
ENV APP_NAME="PuTTY" \
    KEEP_APP_RUNNING=1

# Define mountable directories.
VOLUME ["/config"]

# Metadata.
LABEL \
      org.label-schema.name="putty" \
      org.label-schema.description="Docker container for PuTTY" \
      org.label-schema.version="unknown" \
      org.label-schema.vcs-url="https://github.com/jlesage/docker-putty" \
      org.label-schema.schema-version="1.0"
