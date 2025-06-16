-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font_size = 12
config.color_scheme = "Gruvbox"
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font("Fira Code")

config.window_background_image = wezterm.home_dir .. "/wallpapers/terminalbackground.png"
config.window_background_image_hsb = {
	-- Darken the background image
	brightness = 0.05,

	-- You can adjust the hue by scaling its value.
	-- a multiplier of 1.0 leaves the value unchanged.
	hue = 1.0,

	-- You can adjust the saturation also.
	saturation = 1.0,
}
-- Finally, return the configuration to wezterm:
return config
