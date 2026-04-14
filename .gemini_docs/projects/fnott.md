# fnott Notification Daemon

## Overview

`fnott` is a lightweight Wayland notification daemon. It is configured to match the system-wide `wallust` theme and provide distinct visual feedback based on notification urgency.

## Configuration

- **Path:** `fnott/.config/fnott/fnott.ini`
- **Management:** Managed via `stow fnott`.

## Urgency Levels

Styles and timeouts follow a hierarchy of importance:

| Urgency | Title + Summary Font Size | Body Font Size | Timeout | Background | Border |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Low** | 10px | 9px | 8s | Black (#000000aa) | Grey (#433E47) |
| **Normal** | 11px | 10px | 21s | Black (#000000aa) | Primary Accent (#854D78) |
| **Critical** | 12px | 11px | 55s | Dark Red (#28000055) | Red (#b10000ff) |

## Theming

- Primary text is kept white (`#ffffffff`) for readability.
- Low priority text is greyed out (`#a6adc8ff`) to be less intrusive.
- Critical priority uses red accents for immediate visibility.
