#!/bin/bash
set -e

# Copy the configuration into place
[ -z "${HOMIE_CONFIG_PATH}" ] || export INIFILE="${HOMIE_CONFIG_PATH}"

# Prefix commands if none specified
if [ -z "$@" ]; then
  set -- python /opt/homie-ota/homie-ota.py "$@"
fi

exec "$@"
