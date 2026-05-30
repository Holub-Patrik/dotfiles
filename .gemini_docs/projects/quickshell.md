# Quickshell Configuration (PidgyDots Shell)

This project implements the shell (bar/desktop) for the Linux setup using [Quickshell](https://github.com/quickshell-mirror/quickshell).

## Design Philosophy
- **OLED First:** Designed for 0xFFFFFF on true black.
- **Performance:** Minimal polling, performance trumps easy scriptability.
- **Visuals:** Shadows are preferred over blur for performance.
- **UI Size:** Small font (12px on 1440p) and compact UI.

## Project Structure
- `shell.qml`: Main entry point.
- `Config.qml`: Configuration options.
- `components/`: Individual shell components.
  - `Tray.qml`: System tray icons & consolidated OLED QuickSettings dropdown (volume & brightness sliders).

## Features
- **Consolidated System Tray Dropdown:** The tray component toggles a beautiful OLED popup card (`#000000` true black, 1px white border) containing:
  - System tray application indicators (e.g. Vesktop).
  - A subtle divider separator line.
  - An interactive Volume slider/percentage indicator (clickable and draggable).
  - An interactive Brightness slider/percentage indicator (clickable and draggable).
- **Quickshell IPC Integration:** State properties are updated in real-time by keyboard hotkey presses or external system changes via an `IpcHandler` endpoint targeting `"volume_brightness"`.

## Resources
- Quickshell Reference: https://github.com/quickshell-mirror/quickshell
