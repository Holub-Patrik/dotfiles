# Neovim Configuration

A customized Neovim setup focused on minimalism and performance.

## Core Philosophy
- **Minimalist Plugins:** Keep the plugin count to an absolute minimum.
- **Native over Bloated:** Strong preference for native Neovim features or simple wrappers over complex plugins that bring unnecessary features.
- **Performance:** Fast startup and low resource usage.

## Plugin Management
- **Neovim 0.12+:** Actively testing and using `zpack` (native vim pack wrapper) for a more integrated experience.
- **Legacy (< 0.12):** Falls back to `lazy.nvim` for plugin management.

## Structure
- `init.lua`: Main entry point with version-specific loader logic.
- `lua/`: Configuration modules (options, mappings, configs).
- `after/`: Filetype-specific settings and overrides.
