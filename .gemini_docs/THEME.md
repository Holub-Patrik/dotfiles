# Global Configuration & Theming Standards

## Dotfiles Management
- **Tool:** GNU Stow is used to manage symlinks from the `~/dotfiles` directory to `~/.config`.
- **Workflow:** Each component (e.g., `fnott/`, `fuzzel/`, `hypr/`) mimics the internal structure of the user's home directory.

## Theming & Colors
- **Engine:** `wallust` is used to generate color palettes from wallpapers.
- **Current Source:** `~/Pictures/wallpapers/MyDark.jpg`
- **Accent Colors (Wallust MyDark):**
  - Background: `#1C181F` (To be used sparingly; only when explicitly requested for specific UI components)
  - Primary Accent: `#854D78` (Purple-ish)
  - Secondary Accent: `#AC82A1`
  - Critical/Alert: `#f38ba8` (Red)
- **Design Principles:**
  - **Backgrounds:** Favor pure black (`#000000`) for all UI backgrounds. Use wallust-generated background colors only when a component would specifically benefit from a non-black backdrop.
  - **Text:** Prefer pure white (`#ffffffff`) for primary text to ensure maximum readability against dark backgrounds.
  - **Hierarchy (Notifications/UI):** Use font size and background intensity to indicate importance.
    - Low: Title/Summary (10px), Body (9px), black background (`#000000aa`), greyed text (`#a6adc8ff`), subtle border.
    - Normal: Title/Summary (11px), Body (10px), black background (`#000000aa`), primary accent border.
    - Critical: Title/Summary (12px), Body (11px), dark red tint background (`#28000055`), red border/text.
  - **Window Accessories (Borders & Gaps):** Prioritize utility and functional aesthetics over purely decorative elements.
    - **Borders:** Keep borders minimal, ideally 1px (e.g., Hyprland).
    - **Radius:** Keep border radius small and consistent. For `fnott`, a radius of 2px is used to avoid rendering issues with 1px borders.
    - **Philosophy:** Avoid thick borders or wide gaps unless they solve a specific layout issue or improve container spacing. Accents must signify information or hierarchy.
  - **Consistency:** `fuzzel` and `fnott` should share the same primary accent colors and border styles.

## Component Migration
- Components should be progressively migrated to use these shared `wallust` variables or hex codes to maintain a unified system aesthetic.
