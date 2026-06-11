#!/bin/bash

# Get the resolution of the first monitor (usually primary)
RES=$(hyprctl monitors -j | jq -r '.[0].width')
THEME="phinger-cursors-light"

if [ "$RES" -ge 3840 ]; then
    # 4K Laptop
    DPI=180
    CURSOR=32
elif [ "$RES" -ge 2560 ]; then
    # 1440p PC (Assumed 100% scaling)
    DPI=96
    CURSOR=24
else
    # Default/1080p
    DPI=96
    CURSOR=24
fi

# Apply X11 DPI and rendering settings (for fonts and UI)
cat <<EOF | xrdb -merge
Xft.dpi: $DPI
Xft.autohint: 0
Xft.lcdfilter: lcddefault
Xft.hintstyle: hintfull
Xft.hinting: 1
Xft.antialias: 1
Xft.rgba: rgb
EOF


# Apply Cursor Scale (X11 and Wayland)
hyprctl setcursor "$THEME" "$CURSOR"
export XCURSOR_SIZE="$CURSOR"
export HYPRCURSOR_SIZE="$CURSOR"
dbus-update-activation-environment --systemd XCURSOR_SIZE HYPRCURSOR_SIZE
systemctl --user import-environment XCURSOR_SIZE HYPRCURSOR_SIZE 2>/dev/null || true



# Setup and run xsettingsd dynamically for XWayland apps
XSETTINGS_DPI=$((DPI * 1024))
mkdir -p ~/.config/xsettingsd
cat <<EOF > ~/.config/xsettingsd/xsettingsd.conf
Xft/DPI $XSETTINGS_DPI
Gtk/CursorThemeName "$THEME"
Gtk/CursorThemeSize $CURSOR
EOF

# Restart xsettingsd to apply changes
killall xsettingsd 2>/dev/null
nohup xsettingsd >/dev/null 2>&1 &


