# Hyprland Configuration

This is a minimal Hyprland configuration focused on simplicity, efficiency, and performance.

## Key Features

- **Minimalist:** Only necessary components.
- **Performance First:** No polling scripts, only on-demand execution.
- **OLED Optimized:** Designed with black backgrounds and high-contrast text.

## Programs in Use

- **Launcher:** Fuzzel
- **Editor:** Neovim (Nvim)
- **Terminal:** Kitty
- **File Manager:** Thunar
- **Calculator:** libqalculate (qalc)

## Evolution

Originally based on JaKooLit's Hyprland dots, but transitioned to a unified modern Lua configuration.
The legacy `.conf` files are kept as references, but `hyprland.lua` is the active configuration file.

## Main Configuration Files

- `hyprland.lua`: Unified active configuration file.
- `.luarc.json`: Configuration for `lua_ls` Language Server to map Hyprland stubs.

## Configuration Standards

- **Configuration:** Handled via standard structured Lua tables using the `hl.config()` API.
- **Window Rules:** Defined using `hl.window_rule({ match = { ... }, ... })` using matching tables and action properties.
  - Example:
    ```lua
    hl.window_rule({
        name  = "floating-shell",
        match = { class = "floating_shell" },
        float  = true,
        size   = "600 400",
        center = true,
    })
    ```
- **Keybindings:** Defined using `hl.bind("MOD + Key", hl.dsp.action(), [options])`. Workspaces and other repetitive keybinds are generated programmatically using standard Lua loops.
- **LSP Stubs:** To provide editor auto-completion and diagnostics, `.luarc.json` maps the stubs directory (`/usr/share/hypr/stubs/`) and declares the global variable `hl`.

