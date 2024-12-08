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

return config
