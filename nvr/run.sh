#!/bin/bash
set -e

STREAM_URL=/data/options.json

URL=$(jq --raw-output ".stream" $STREAM_URL)

mkdir -p /share/nvr
echo "Ready for input..."
echo "Stream: $URL"

# Read text from STDIN
while read -r input; do
    seconds="$(echo "$input" | jq --raw-output '.')"
    filename="/share/nvr/$(date +%Y%m%d_%H%M).mp4"
    echo "[Info] Start capture $filename"
    ffmpeg -t "$seconds" -i $URL -acodec copy -vcodec copy $filename
    echo "[Info] End capture"
done

