#!/bin/bash
set -e

echo "Ready for input..."

# Read input from STDIN
while read input; do
    echo "Read $input"
    if ! msg="$(node /config/${input//\"}.js)"; then
    	echo "[Error] Chart failed $msg"
    fi
	echo "Ready for next..."
done

echo "Exiting..."

# Usage: {"addon":"local_chart_node", "input":"example"}
