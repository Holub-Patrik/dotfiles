#!/bin/bash

# Get the resolution of the first monitor (usually primary)
RES=$(hyprctl monitors -j | jq -r '.[0].width')
THEME="phinger-cursors-light"

if [ "$RES" -ge 3840 ]; then
    # 4K Laptop
    DPI=144
    CURSOR=24
elif [ "$RES" -ge 2560 ]; then
    # 1440p PC (Assumed 100% scaling)
    DPI=96
    CURSOR=24
else
    # Default/1080p
    DPI=96
    CURSOR=24
fi

# Apply X11 DPI (for fonts and UI)
echo "Xft.dpi: $DPI" | xrdb -merge

# Apply Cursor Scale (X11 and Wayland)
hyprctl setcursor "$THEME" "$CURSOR"
export XCURSOR_SIZE="$CURSOR"
export HYPRCURSOR_SIZE="$CURSOR"
