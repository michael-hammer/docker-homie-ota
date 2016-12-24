#!/bin/bash
set -e

# Set environment
export HOMIE_CONFIG_PATH=${HOMIE_CONFIG_PATH:-/opt/homie-ota/homie-ota.ini.example}

# Copy the configuration into place
cp -v ${HOMIE_CONFIG_PATH} /opt/homie-ota/homie-ota.ini

# Call the base entrypoint script
/opt/homie-ota/homie-ota.py "$@"
