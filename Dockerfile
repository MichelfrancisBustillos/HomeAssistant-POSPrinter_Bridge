ARG BUILD_FROM=ghcr.io/hassio-addons/base:19.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Copy root filesystem
COPY requirements.txt /tmp/requirements.txt
RUN apk update
RUN apk add python3
RUN apk add py3-pip
RUN cd /usr/local/bin
RUN python -m venv /usr/local/bin/POSPrinter_Bridge
ENV PATH="/usr/local/bin/POSPrinter_Bridge/bin:$PATH"
RUN pip install -r /tmp/requirements.txt

COPY src/ /usr/local/bin/

EXPOSE 8000

#CMD ["python3", "/usr/local/bin/main.py"]
COPY run.sh /usr/local/bin/run.sh
RUN chmod a+x /usr/local/bin/run.sh
CMD ["/usr/local/bin/run.sh"]

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="MichelfrancisBustillos <michelfrancisbustillos@gmail.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="MichelfrancisBustillos <michelfrancisbustillos@gmail.com>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}