#!/bin/bash
set -e

# Copy the configuration into place
[ -z "${HOMIE_CONFIG_PATH}" ] || cp -v ${HOMIE_CONFIG_PATH} /opt/homie-ota/homie-ota.ini

# Prefix commands if none specified
if [ -z "$@" ]; then
  set -- python /opt/homie-ota/homie-ota.py "$@"
fi

exec "$@"
