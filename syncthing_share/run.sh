#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

USERNAME=$(jq --raw-output ".username" $CONFIG_PATH)
PASSWORD=$(jq --raw-output ".password" $CONFIG_PATH)
SYNC_DIR=$(jq --raw-output ".sync_dir" $CONFIG_PATH)

if [ ! -f '/data/config.xml' ]; then
    # Run syncthing to generate initial configuration files, then edit
    # config.xml to remove 127.0.0.1 limit from the GUI address.
    syncthing -generate=/data
    sed -i 's|<address>127.0.0.1:8384</address>|<address>:8384</address>|' /data/config.xml
fi

# Init user
addgroup "${USERNAME}"
adduser -D -H -G "${USERNAME}" -s /bin/false "${USERNAME}"
echo -e "${PASSWORD}\n${PASSWORD}" | passwd "${USERNAME}"
chown -R "${USERNAME}":"${USERNAME}" /data
mkdir -p "$SYNC_DIR"
chown -R "${USERNAME}":"${USERNAME}" "$SYNC_DIR"

# Launch syncthing as user
su -s /bin/bash "${USERNAME}" -c 'syncthing -no-browser -home=/data/'

