#!/bin/bash

# Simple script to test notifications

# Check if notify-send is available
if ! command -v notify-send &> /dev/null; then
    echo "Error: notify-send is not installed. Please install libnotify."
    exit 1
fi

# Send a few test notifications
notify-send "Low Priority" "This is a low priority notification." -u low
sleep 1
notify-send "Normal Priority" "This is a normal priority notification. It should look like your fuzzel style." -u normal
sleep 1
notify-send "CRITICAL" "This is a critical notification! Should have a red border/text." -u critical

echo "Sent 3 test notifications (low, normal, critical)."
echo "If fnott is running with the new config, you should see them now."
