#!/usr/bin/env bash

# Variables
time=$(date "+%d-%b_%H-%M-%S")
dir="$HOME/Pictures/screenshots"
file="Screenshot_${time}_${RANDOM}.png"

# Create directory if it doesn't exist
if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# Take screenshot
# 1. Select area with slurp
# 2. Capture with grim
# 3. Save to file
# 4. Copy to clipboard
grim -g "$(slurp)" "$dir/$file"
if [[ -f "$dir/$file" ]]; then
    wl-copy < "$dir/$file"
fi
