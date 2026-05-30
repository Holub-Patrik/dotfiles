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

## Future Roadmap & Ideas
- **Connected Dropdown Silhouette:** Draw a visual silhouette (e.g., using a custom triangle connector shape or smooth gradient merging) to make all dropdown popups feel physically "connected" to the main status bar rather than floating, inspired by premium shells like Noctalia.
- **Coherent QT/GTK Theme:** Design a custom QT/Kvantum and GTK theme that matches the bar's OLED-first true black and high-contrast outline design. This would styling application menus (such as Vesktop's right-click menu) in perfect harmony with the desktop shell.

## Resources
- Quickshell Reference: https://github.com/quickshell-mirror/quickshell
