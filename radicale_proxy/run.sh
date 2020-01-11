#!/bin/bash
set -e

CONFIG_PATH=/data/options.json
DHPARAMS_PATH=/data/dhparams.pem

# Read options
DOMAIN=$(jq --raw-output ".domain" $CONFIG_PATH)
CERTFILE=$(jq --raw-output ".certfile" $CONFIG_PATH)
KEYFILE=$(jq --raw-output ".keyfile" $CONFIG_PATH)
CAFILE=$(jq --raw-output ".cafile" $CONFIG_PATH)
PWFILE=$(jq --raw-output ".pwfile" $CONFIG_PATH)
URL=$(jq --raw-output ".url" $CONFIG_PATH)
USER=$(jq --raw-output ".user" $CONFIG_PATH)

# Generate dhparams
if [ ! -f "$DHPARAMS_PATH" ]; then
  echo "[INFO] Generating dhparams (this will take some time)..."
  openssl dhparam -dsaparam -out "$DHPARAMS_PATH" 4096 > /dev/null
fi

# Prepare config file
sed -i "s/%%DOMAIN%%/$DOMAIN/g" /etc/nginx.conf
sed -i "s/%%CERTFILE%%/$CERTFILE/g" /etc/nginx.conf
sed -i "s/%%KEYFILE%%/$KEYFILE/g" /etc/nginx.conf
sed -i "s/%%CAFILE%%/$CAFILE/g" /etc/nginx.conf
sed -i "s/%%PWFILE%%/$PWFILE/g" /etc/nginx.conf
sed -i "s|%%URL%%|$URL|g" /etc/nginx.conf
sed -i "s|%%USER%%|$USER|g" /etc/nginx.conf

# start server
echo "[INFO] Running nginx..."
exec nginx -c /etc/nginx.conf < /dev/null

