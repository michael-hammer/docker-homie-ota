#
# Homie OTA server docker image
#
# http://github.com/tenstartups/homie-ota-docker
#

FROM tenstartups/alpine:latest

MAINTAINER Marc Lennox <marc.lennox@gmail.com>

# Set environment.
ENV \
  HOMIE_OTA_VERSION=4540f1a54d9465bd07b7caaf943f6d950e61f129 \
  LOGFILE=/dev/stdout

# Install base packages.
RUN \
  apk --update add \
    build-base \
    git \
    python2-dev \
    py2-pip && \
    pip install --upgrade pip && \
  rm -rf /var/cache/apk/*

# Install Homie OTA from source.
RUN \
#  wget https://github.com/jpmens/homie-ota/archive/${HOMIE_OTA_VERSION}.tar.gz -O /tmp/homie-ota-${HOMIE_OTA_VERSION}.tar.gz && \
#  tar xvzf /tmp/homie-ota-${HOMIE_OTA_VERSION}.tar.gz -C /tmp && \
  mkdir -p /tmp/homie-ota-${HOMIE_OTA_VERSION} && \
  git clone https://github.com/jpmens/homie-ota /tmp/homie-ota-${HOMIE_OTA_VERSION} && \
  cd /tmp/homie-ota-${HOMIE_OTA_VERSION} && \
  git reset --hard ${HOMIE_OTA_VERSION} && \
  rm -rf /tmp/homie-ota-${HOMIE_OTA_VERSION}/.git && \
  cd /tmp/homie-ota-${HOMIE_OTA_VERSION} && \
  pip install -r requirements.txt && \
  cd / && \
  mkdir /opt && \
  mv /tmp/homie-ota-${HOMIE_OTA_VERSION} /opt/homie-ota

# Set the working directory
WORKDIR /opt/homie-ota

# Copy the new entrypoint script into place.
COPY entrypoint.sh /docker-entrypoint.sh

# Change the entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
