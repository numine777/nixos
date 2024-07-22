-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"

config.window_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

config.font = wezterm.font_with_fallback({
    "BerkeleyMono Nerd Font",
})

config.font_size = 16.0
config.window_decorations = "None"
-- config.color_scheme = 'Gruvbox Material (Gogh)'
config.color_scheme = 'GruvboxDarkHard'

-- and finally, return the configuration to wezterm
return config
