#!/usr/bin/env bash

# Volume control script using pamixer

# Functions
get_volume() {
    pamixer --get-volume-human
}

inc_volume() {
    pamixer -i 5
}

dec_volume() {
    pamixer -d 5
}

toggle_mute() {
    pamixer -t
}

toggle_mic() {
    pamixer --default-source -t
}

# Execute based on flag
case "$1" in
    --get)
        get_volume
        ;;
    --inc)
        inc_volume
        ;;
    --dec)
        dec_volume
        ;;
    --toggle)
        toggle_mute
        ;;
    --toggle-mic)
        toggle_mic
        ;;
    *)
        echo "Usage: $0 {--get|--inc|--dec|--toggle|--toggle-mic}"
        exit 1
        ;;
esac
