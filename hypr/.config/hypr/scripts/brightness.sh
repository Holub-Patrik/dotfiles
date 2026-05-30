#!/usr/bin/env bash

# Monitor brightness control helper script wrapping brightnessctl

get_brightness() {
    brightnessctl -m | cut -d, -f4 | tr -d '%'
}

set_brightness() {
    local val="$1"
    # Ensure value is between 0 and 100
    if [ "$val" -lt 0 ]; then val=0; fi
    if [ "$val" -gt 100 ]; then val=100; fi
    brightnessctl set "${val}%" >/dev/null
}

inc_brightness() {
    brightnessctl set 5%+ >/dev/null
}

dec_brightness() {
    brightnessctl set 5%- >/dev/null
}

trigger_quickshell() {
    if command -v qs >/dev/null 2>&1; then
        qs ipc call volume_brightness updateBrightness >/dev/null 2>&1 || true
    elif command -v quickshell >/dev/null 2>&1; then
        quickshell ipc call volume_brightness updateBrightness >/dev/null 2>&1 || true
    fi
}

case "$1" in
    --get)
        get_brightness
        ;;
    --inc)
        inc_brightness
        trigger_quickshell
        ;;
    --dec)
        dec_brightness
        trigger_quickshell
        ;;
    --set)
        if [ -n "${2:-}" ]; then
            set_brightness "$2"
            trigger_quickshell
        else
            echo "Error: Missing percentage value for --set" >&2
            exit 1
        fi
        ;;
    *)
        echo "Usage: $0 {--get|--inc|--dec|--set <0-100>}"
        exit 1
        ;;
esac
