#
# Homie OTA server docker image
#
# http://github.com/tenstartups/homie-ota-docker
#

FROM tenstartups/alpine:latest

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV \
  HOMIE_OTA_VERSION=0.4

# Install base packages.
RUN \
  apk --update add \
    build-base \
    python-dev \
    py-pip && \
    pip install --upgrade pip && \
  rm -rf /var/cache/apk/*

# Install Homie OTA from source.
RUN \
  mkdir /opt && \
  wget https://github.com/jpmens/homie-ota/archive/${HOMIE_OTA_VERSION}.tar.gz -O /tmp/homie-ota-${HOMIE_OTA_VERSION}.tar.gz && \
  tar xvzf /tmp/homie-ota-${HOMIE_OTA_VERSION}.tar.gz -C /tmp && \
  cd /tmp/homie-ota-${HOMIE_OTA_VERSION} && \
  pip install -r requirements.txt && \
  mkdir -p /opt/homie-ota && \
  cp *.py /opt/homie-ota && \
  cp *.ini.example /opt/homie-ota && \
  find / | grep bottle && \
  cd / && \
  rm -rf /tmp/homie-ota-${HOMIE_OTA_VERSION}*

# Copy the new entrypoint script into place.
COPY entrypoint.sh /docker-entrypoint.sh

# Change the entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
