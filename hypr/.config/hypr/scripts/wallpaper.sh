#!/usr/bin/env bash

# Directory containing wallpapers
wall_dir="$HOME/Pictures/wallpapers"

# Fuzzel command to select wallpaper
select_wall() {
    ls "$wall_dir" | fuzzel --dmenu --prompt="󰸉 Select Wallpaper: " --width=40
}

# Apply wallpaper
apply_wall() {
    local wall="$1"
    local full_path="$wall_dir/$wall"
    
    if [[ -f "$full_path" ]]; then
        # Preload and set wallpaper
        hyprctl hyprpaper preload "$full_path"
        hyprctl hyprpaper wallpaper ",$full_path"
        
        # Update config for persistence
        # Note: This assumes hyprpaper.conf is in ~/.config/hypr/
        # Adjusting to the local path if needed, but ~/.config/hypr/ is standard
        conf_file="$HOME/.config/hypr/hyprpaper.conf"
        if [[ -f "$conf_file" ]]; then
            sed -i "s|preload = .*|preload = $full_path|" "$conf_file"
            sed -i "s|wallpaper = .*|wallpaper = ,$full_path|" "$conf_file"
        fi
    fi
}

# Main execution
chosen=$(select_wall)
if [[ -n "$chosen" ]]; then
    apply_wall "$chosen"
fi
