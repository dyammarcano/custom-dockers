#!/bin/bash

export BORG_VERSION=${1:-"1.1.16"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

if [ "${BORG_VERSION}" != "" ]; then
    wget https://github.com/borgbackup/borg/releases/download/${BORG_VERSION}/borg-linux64 \
    && mv borg-linux64 /bin/borg \
    && chown root:root /bin/borg \
    && chmod 755 /bin/borg
fi

echo "Done!"
