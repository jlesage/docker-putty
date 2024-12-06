#
# putty Dockerfile
#
# https://github.com/jlesage/docker-putty
#

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=

# Define software versions.
ARG PUTTY_VERSION=0.82

# Define software download URLs.
ARG PUTTY_URL=https://the.earth.li/~sgtatham/putty/${PUTTY_VERSION}/putty-${PUTTY_VERSION}.tar.gz

# Get Dockerfile cross-compilation helpers.
FROM --platform=$BUILDPLATFORM tonistiigi/xx AS xx

# Build PuTTY.
FROM --platform=$BUILDPLATFORM alpine:3.20 AS putty
ARG TARGETPLATFORM
ARG PUTTY_URL
COPY --from=xx / /
COPY src/putty /build
RUN /build/build.sh "$PUTTY_URL"
RUN xx-verify \
    /tmp/putty-install/usr/bin/putty \
    /tmp/putty-install/usr/bin/plink \
    /tmp/putty-install/usr/bin/pscp \
    /tmp/putty-install/usr/bin/psftp \
    /tmp/putty-install/usr/bin/psusan \
    /tmp/putty-install/usr/bin/puttygen \
    /tmp/putty-install/usr/bin/pageant \
    /tmp/putty-install/usr/bin/pterm

# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.20-v4.6.7

ARG PUTTY_VERSION
ARG DOCKER_IMAGE_VERSION

# Define working directory.
WORKDIR /tmp

# Install dependencies.
RUN add-pkg \
        gtk+3.0 \
        adwaita-icon-theme \
        # A font is needed.
        ttf-dejavu

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://github.com/jlesage/docker-templates/raw/master/jlesage/images/putty-icon.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /
COPY --from=putty /tmp/putty-install/usr/bin /usr/bin

# Set internal environment variables.
RUN \
    set-cont-env APP_NAME "PuTTY" && \
    set-cont-env APP_VERSION "$PUTTY_VERSION" && \
    set-cont-env DOCKER_IMAGE_VERSION "$DOCKER_IMAGE_VERSION" && \
    true

# Metadata.
LABEL \
      org.label-schema.name="putty" \
      org.label-schema.description="Docker container for PuTTY" \
      org.label-schema.version="${DOCKER_IMAGE_VERSION:-unknown}" \
      org.label-schema.vcs-url="https://github.com/jlesage/docker-putty" \
      org.label-schema.schema-version="1.0"
