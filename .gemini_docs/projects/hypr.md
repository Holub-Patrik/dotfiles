# Hyprland Configuration

This is a minimal Hyprland configuration focused on simplicity, efficiency, and performance.

## Key Features

- **Minimalist:** Only necessary components.
- **Performance First:** No polling scripts, only on-demand execution.
- **OLED Optimized:** Designed with black backgrounds and high-contrast text.

## Programs in Use

- **Launcher:** Fuzzel
- **Editor:** Neovim (Nvim)
- **Terminal:** Kitty
- **File Manager:** Thunar
- **Calculator:** libqalculate (qalc)

## Evolution

Originally based on JaKooLit's Hyprland dots, but transitioning to a custom implementation.
This directory is present in hypr/.config/hypr/JaKooLit for reference

## Main Configuration Files

- `hyprland.conf`: Main configuration.
- `conf/keybinds.conf`: Keybindings.
- `conf/startup.conf`: Autostart applications.
- `conf/colors.conf`: Aesthetic settings.

## Configuration Standards

- **Window Rules:** Use the modern `windowrule` syntax (v0.48+). Avoid the deprecated `windowrulev2`.
  - Format: `windowrule = match:<field> <pattern>, <action> <value>`
  - Example: `windowrule = match:class (kitty), float 1`
