#!/usr/bin/env bash

# Options
lock="󰌾 Lock"
suspend="󰤄 Suspend"
logout="󰗽 Logout"
reboot="󰜉 Reboot"
shutdown="󰐥 Shutdown"

# Fuzzel CMD
fuzzel_cmd() {
    fuzzel --dmenu \
        --prompt="Power Menu: " \
        --lines=5 \
        --width=20
}

# Pass variables to command
run_fuzzel() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | fuzzel_cmd
}

# Execute Command
run_cmd() {
    case $1 in
        --shutdown)
            systemctl poweroff
            ;;
        --reboot)
            systemctl reboot
            ;;
        --suspend)
            systemctl suspend
            ;;
        --logout)
            hyprctl dispatch exit 0
            ;;
        --lock)
            hyprlock
            ;;
    esac
}

# Actions
chosen="$(run_fuzzel)"
case ${chosen} in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $lock)
        run_cmd --lock
        ;;
    $suspend)
        run_cmd --suspend
        ;;
    $logout)
        run_cmd --logout
        ;;
esac
