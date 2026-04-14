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

## Rules for Development
- **Git Branching:** Work in branches and merge new features.
- **File Structure:** Use separate files in branches and consolidate them during merge if necessary.
- **Iterative Updates:** Files are saved and formatted often; visuals are updated frequently based on user feedback.
- **Precision:** Use granular search and replace to avoid breaking code blocks.

## Resources
- Quickshell Reference: https://github.com/quickshell-mirror/quickshell
