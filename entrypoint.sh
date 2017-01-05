#!/bin/bash
set -e

# Copy the configuration into place
[ -z "${HOMIE_CONFIG_PATH}" ] || export INIFILE="${HOMIE_CONFIG_PATH}"

# Create firmware directory
[ -z "${INIFILE}" ] || (
dirname $(cat ${INIFILE} | grep OTA_FIRMWARE_ROOT | sed 's/OTA_FIRMWARE_ROOT.*=\s*//')
  mkdir -p "$(cat ${INIFILE} | grep OTA_FIRMWARE_ROOT | sed 's/OTA_FIRMWARE_ROOT.*=\s*//')"
)

# Prefix commands if none specified
if [ -z "$@" ]; then
  set -- python /opt/homie-ota/homie-ota.py "$@"
fi

exec "$@"
