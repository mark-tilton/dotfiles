-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font_size = 12
config.color_scheme = 'Rosé Pine Moon (Gogh)'
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font("Fira Code")
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9

local hsb = {
	brightness = 0.05,
	hue = 1.0,
	saturation = 0.9,
}

local background = {
	{
		source = {
			Color = "#0f112d",
		},
		hsb = hsb,
		width = "100%",
		height = "100%",
	},
	{
		source = {
			File = wezterm.home_dir ..
			    "/wallpapers/terminalbackground.jpg",
		},
		hsb = hsb,
		vertical_align = "Middle",
		horizontal_align = "Center",
		repeat_x = "NoRepeat",
		height = "Cover",
		width = "Cover",
	},
}

-- Uncomment this line to enable terminal background
-- config.background = background

return config
