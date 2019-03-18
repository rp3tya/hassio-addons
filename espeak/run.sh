#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

LANG=$(jq --raw-output ".language" $CONFIG_PATH)

echo "Ready for input..."

# Read text to speak from STDIN
while read -r input; do
    # remove JSON stuff
    words="$(echo "$input" | jq --raw-output '.')"
    echo "[Info] Read text: $words"
    if ! msg="$(espeak --stdout -v "$LANG" "$words" | play -t wav -)"; then
    	echo "[Error] Speak failed -> $msg"
    fi
done

