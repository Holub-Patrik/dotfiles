# PidgyDots - Gemini CLI Documentation

This directory contains information about the various projects and configurations in the `PidgyDots` repository.

## Core Philosophy
- **OLED First:** Designed for 0xFFFFFF on true black.
- **Minimalism:** No distractions, performance-driven, minimal polling.
- **Transparency & Shadows:** Preference for shadows over blur to save resources.
- **Efficiency:** Small fonts (12px on 1440p), small UI elements, and minimal application footprint.

## Active Projects
- [Hyprland](projects/hypr.md): Minimalist window manager configuration.
- [Quickshell](projects/quickshell.md): Shell/Bar implementation using Quickshell (QML).
- [SDDM (kath_sddm)](projects/kath_sddm.md): Custom SDDM theme.
- [Neovim](projects/nvim.md): Main text editor.
- [Kitty](projects/kitty.md): Primary terminal emulator.
- [Fuzzel](projects/fuzzel.md): Application launcher.
- [Fnott](projects/fnott.md): Notification daemon.
- [Zsh](projects/zsh.md): Shell configuration.
- [Scripts](projects/scripts.md): Local helper scripts.
- [Dark Theme](projects/dark_theme.md): Kvantum/QT theme settings.
- [SSH](projects/ssh.md): SSH client configuration.
- [Theme Standards](THEME.md): Shared wallust-based colors and stow management.

## Setup & Installation
- `install.sh`: Legacy/Current install script.
- `setup/`: Directory with specialized setup scripts (AUR, base, fonts, etc.).
- `stow`: Primary tool for managing dotfiles in the `~/dotfiles` repository.

## Documentation Maintenance
- **Mandate:** AI agents MUST update the `.gemini_docs` knowledge base after completing a task (once confirmed by the user) to ensure documentation remains accurate and reflects the current state of the codebase.
- This includes updating project-specific files, theme standards, and the main overview.
