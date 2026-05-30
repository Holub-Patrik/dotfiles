#!/usr/bin/env bash

# Volume control script using pamixer

# Functions
get_volume() {
    pamixer --get-volume-human
}

set_volume() {
    pamixer --set-volume "$1"
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

trigger_quickshell() {
    if command -v qs >/dev/null 2>&1; then
        qs ipc call volume_brightness updateVolume >/dev/null 2>&1 || true
    elif command -v quickshell >/dev/null 2>&1; then
        quickshell ipc call volume_brightness updateVolume >/dev/null 2>&1 || true
    fi
}

# Execute based on flag
case "$1" in
    --get)
        get_volume
        ;;
    --inc)
        inc_volume
        trigger_quickshell
        ;;
    --dec)
        dec_volume
        trigger_quickshell
        ;;
    --set)
        if [ -n "${2:-}" ]; then
            set_volume "$2"
            trigger_quickshell
        else
            echo "Error: Missing percentage value for --set" >&2
            exit 1
        fi
        ;;
    --toggle)
        toggle_mute
        trigger_quickshell
        ;;
    --toggle-mic)
        toggle_mic
        trigger_quickshell
        ;;
    *)
        echo "Usage: $0 {--get|--inc|--dec|--set <0-100>|--toggle|--toggle-mic}"
        exit 1
        ;;
esac
