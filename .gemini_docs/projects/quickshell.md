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
- **Consolidated System Tray Dropdown:** The tray component toggles a beautiful connected OLED popup card (`#000000` true black) containing:
  - System tray application indicators (e.g. Vesktop).
  - A subtle divider separator line.
  - An interactive Volume slider/percentage indicator (clickable and draggable).
  - An interactive Brightness slider/percentage indicator (clickable and draggable).
  The card's height is fully dynamic, automatically recalculating based on the layout's implicit height (such as dynamically hiding/showing the tray icon row and divider depending on whether any active system tray items exist). This makes it seamless to add future widgets without editing pixel bounds manually.
- **Connected Dropdown Silhouette:** Renders a gorgeous visual bridge to the bar using custom QML `Shape` components with matching `5px` outer connection radii and bottom corner rounding. The outline border is styled in the exact Hyprland active border color (`#cba6f7` Violet) and remains **fully solid** along the entire connecting curves and card sides. To create a flawless visual fade into the bar, the curves extend horizontally along the bar's bottom edge by `15px` (`fadeLength: 15`) and utilize horizontal `LinearGradient` extensions that **smoothly fade to transparent** at their tips. This ensures a solid, beautifully defined violet transition that looks exceptionally clean on empty workspaces and blends seamlessly with Hyprland active window borders when present.
- **Quickshell IPC Integration:** State properties are updated in real-time by keyboard hotkey presses or external system changes via an `IpcHandler` endpoint targeting `"volume_brightness"`.

## Future Roadmap & Ideas
- **Coherent QT/GTK Theme:** Design a custom QT/Kvantum and GTK theme that matches the bar's OLED-first true black and high-contrast outline design. This would style application menus (such as Vesktop's right-click menu) in perfect harmony with the desktop shell.

## Resources
- Quickshell Reference: https://github.com/quickshell-mirror/quickshell
