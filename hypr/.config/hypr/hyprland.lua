-- PidgyDots - Hyprland Lua Configuration
-- Focuses on simplicity, OLED optimization, and high performance.
-- Refer to https://wiki.hypr.land/ for full API documentation.

--------------------------------------------------------------------------------
-- 1. MONITORS & WORKSPACES
--------------------------------------------------------------------------------

-- Configure display (OLED eDP-1, 10-bit depth for rich colors)
hl.monitor({
    output   = "eDP-1",
    mode     = "3840x2400@60.0",
    position = "0x0",
    scale    = 1.4999999999999996,
    bitdepth = 10,
})

-- Default monitor-workspace assignments
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1" })

--------------------------------------------------------------------------------
-- 2. ENVIRONMENT VARIABLES
--------------------------------------------------------------------------------

hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_QUICK_CONTROLS_STYLE", "org.hyprland.style")
hl.env("GDK_SCALE", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Nvidia specific variables
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("GSK_RENDERER", "ngl")

--------------------------------------------------------------------------------
-- 3. LOOK & FEEL (OLED-FIRST & PERFORMANCE-ORIENTED)
--------------------------------------------------------------------------------

hl.config({
    general = {
        layout = "dwindle",
        border_size = 1,
        gaps_in = 0,
        gaps_out = 0,
        resize_on_border = true,
        col = {
            active_border   = "rgba(cba6f7ff)", -- Sleek Violet
            inactive_border = "rgba(313244ff)",
        },
    },

    decoration = {
        rounding = 5,
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        -- Shadows preferred over blur for performance and OLED elegance
        shadow = {
            enabled = false,
            range = 10,
            render_power = 3,
            color = "rgba(000000ee)",
        },

        blur = {
            enabled = false,
        },

        dim_inactive = false,
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        vrr = 2,    -- Fullscreen VRR Adaptive Sync
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        focus_on_activate = false,
    },

    debug = {
        vfr = true, -- Variable Frame Rate (saves substantial battery/CPU)
    },

    xwayland = {
        force_zero_scaling = true,
    },

    input = {
        kb_layout    = "us, cz",
        kb_variant   = ", qwerty",
        kb_options   = "grp:alt_shift_toggle",
        follow_mouse = 1,
        sensitivity  = 0,

        touchpad     = {
            natural_scroll = true,
            disable_while_typing = true,
        },
    },

    cursor = {
        no_warps = false,
        warp_on_change_workspace = true,
    },
})

--------------------------------------------------------------------------------
-- 4. BÉZIER CURVES & ANIMATIONS
--------------------------------------------------------------------------------

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("fastBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })
hl.curve("popBezier", { type = "bezier", points = { { 0.175, 0.885 }, { 0.32, 1.275 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "popBezier" })

--------------------------------------------------------------------------------
-- 5. WINDOW RULES
--------------------------------------------------------------------------------

-- Enable float for XWayland drag-and-drop
hl.window_rule({
    name  = "xwayland-float",
    match = { xwayland = true },
    float = true,
})

-- Floating shell / Calculator
hl.window_rule({
    name   = "floating-shell",
    match  = { class = "floating_shell" },
    float  = true,
    size   = "600 400",
    center = true,
})

--------------------------------------------------------------------------------
-- 6. AUTOSTART (PROCESSES)
--------------------------------------------------------------------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("quickshell") -- Start custom QML bar
    hl.exec_cmd("hyprpaper")  -- Wallpapers
    hl.exec_cmd("fnott")      -- Notifications
    hl.exec_cmd("~/.config/hypr/scripts/scaling.sh")
end)

--------------------------------------------------------------------------------
-- 7. KEYBINDINGS
--------------------------------------------------------------------------------

local mainMod = "SUPER"
local term    = "kitty"
local files   = "kitty -e yazi"
local browser = 'xdg-open "https://"'

-- Application launchers
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("fuzzel"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("~/.config/hypr/scripts/calculator.sh"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh"))
hl.bind("CTRL + SHIFT + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/powermenu.sh"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))

-- Window operations
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Navigation focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move window positioning
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Workspaces switching and moving windows (1-10 mapped dynamically)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Mouse operations (drag, resize)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Audio/Media bindings (hardware keys)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh --inc"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh --dec"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh --toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh --toggle-mic"), { locked = true })

-- Screen brightness bindings (hardware keys)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"),                    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"),                    { locked = true, repeating = true })

-- Keyboard backlight brightness bindings (hardware keys)
hl.bind("XF86KbdBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -d 'asus::kbd_backlight' set 1+"), { locked = true, repeating = true })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d 'asus::kbd_backlight' set 1-"), { locked = true, repeating = true })

