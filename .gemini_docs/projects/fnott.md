# fnott Notification Daemon

## Overview
`fnott` is a lightweight Wayland notification daemon. It is configured to match the system-wide `wallust` theme and provide distinct visual feedback based on notification urgency.

## Configuration
- **Path:** `fnott/.config/fnott/fnott.ini`
- **Management:** Managed via `stow fnott`.

## Urgency Levels
Styles and timeouts follow a hierarchy of importance:

| Urgency | Font Size | Timeout | Background | Border |
| :--- | :--- | :--- | :--- | :--- |
| **Low** | 11px | 8s | Black (#000000) | Grey (#433E47) |
| **Normal** | 12px | 21s | Wallust BG (#1C181F) | Primary Accent (#854D78) |
| **Critical** | 13px | 55s | Wallust BG (#1C181F) | Red (#f38ba8) |

## Theming
- Primary text is kept white (`#ffffffff`) for readability.
- Low priority text is greyed out (`#a6adc8ff`) to be less intrusive.
- Critical priority uses red accents for immediate visibility.
