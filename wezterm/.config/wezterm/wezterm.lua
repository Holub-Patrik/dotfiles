local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font({
	family = "MonaspiceNe Nerd Font",
	harfbuzz_features = {
		"calt=1",
		"liga=1",
		"ss01=1",
		"ss02=1",
		"ss03=1",
		"ss04=1",
		"ss05=1",
		"ss07=1",
		"ss08=1",
		"ss09=1",
	},
})

config.default_cursor_style = "SteadyUnderline"

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.colors = {
	tab_bar = {
		background = "#000000",

		-- The active tab is the one that has focus in the window
		active_tab = {
			bg_color = "#000000",
			fg_color = "#ffffff",

			intensity = "Normal",
			underline = "None",
			italic = true,
			strikethrough = false,
		},

		inactive_tab = {
			bg_color = "#000000",
			fg_color = "#808080",
		},

		inactive_tab_hover = {
			bg_color = "#000000",
			fg_color = "#909090",
			italic = true,
		},

		new_tab = {
			bg_color = "#000000",
			fg_color = "#808080",
		},

		new_tab_hover = {
			bg_color = "#000000",
			fg_color = "#909090",
			italic = true,
		},
	},
}

config.window_background_opacity = 0.5

config.keys = {
	{
		key = "|",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "\\",
		mods = "CTRL",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
}

-- config.color_scheme = "Builtin Tango Dark"
-- config.color_scheme = "Paul Millr (Gogh)"
config.color_scheme = "Symphonic (Gogh)"

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab)
	local program = basename(tab.active_pane.foreground_process_name)
	return {
		{ Text = " " .. tab.tab_index + 1 .. ":" .. program .. " |" },
	}
end)

return config
