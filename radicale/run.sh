#!/bin/bash

set -e

CONFIG_PATH=/data/options.json

USER=$(jq --raw-output ".user" $CONFIG_PATH)

python3 -m radicale

