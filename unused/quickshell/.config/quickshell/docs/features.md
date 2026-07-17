# Features & Design Decisions

## Bar
### Workspaces
- **Source**: Hyprland
- **Filtering**: Negative workspace IDs are hidden (special workspaces).
- **Labeling**: 
  - IDs 1-10 are displayed as Japanese Kanji (一, 二, 三, 四, 五, 六, 七, 八, 九, 十).
  - IDs > 10 fallback to standard Arabic numerals.
- **Style**: Minimalist, high contrast (OLED friendly).

### Clock
- **Format**: 24-hour (hh:mm).
- **Position**: Right aligned.
- **Style**: White text, matching workspaces.

### System Tray
- **Source**: System Tray (DBus)
- **Position**: Right aligned (left of Clock).
- **Interaction**:
  - Left Click: Activate item.
  - Right Click: Open menu (if available).
- **Style**: Icons size matches font size.