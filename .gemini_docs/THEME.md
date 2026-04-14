# Global Configuration & Theming Standards

## Dotfiles Management
- **Tool:** GNU Stow is used to manage symlinks from the `~/dotfiles` directory to `~/.config`.
- **Workflow:** Each component (e.g., `fnott/`, `fuzzel/`, `hypr/`) mimics the internal structure of the user's home directory.

## Theming & Colors
- **Engine:** `wallust` is used to generate color palettes from wallpapers.
- **Current Source:** `~/Pictures/wallpapers/MyDark.jpg`
- **Accent Colors (Wallust MyDark):**
  - Background: `#1C181F`
  - Primary Accent: `#854D78` (Purple-ish)
  - Secondary Accent: `#AC82A1`
  - Critical/Alert: `#f38ba8` (Red)
- **Design Principles:**
  - **Text:** Prefer pure white (`#ffffffff`) for primary text to ensure maximum readability against dark backgrounds.
  - **Hierarchy:** Use font size and background intensity to indicate importance.
    - Low: Small font (11px), dark/black background, greyed text.
    - Normal: Medium font (12px), accent border.
    - Critical: Large font (13px), red border/text.
  - **Consistency:** `fuzzel` and `fnott` should share the same primary accent colors and border styles.

## Component Migration
- Components should be progressively migrated to use these shared `wallust` variables or hex codes to maintain a unified system aesthetic.
