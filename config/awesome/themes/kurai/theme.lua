local dpi = require("beautiful.xresources").apply_dpi
local gears = require "gears"

local gfs = require "gears.filesystem"
local themes_path = gfs.get_themes_dir()
local theme_path = gfs.get_configuration_dir() .. "/themes/cafe/"
local icons_path = gfs.get_configuration_dir() .. "/icons/"

local theme = {}

theme.font = "Cartograph CF Regular 8"
theme.font_name = "Cartograph CF Regular "

theme.bg_normal = "#191513"
theme.bg_focus = "#302824"
theme.bg_subtle = "#211b19"
theme.bg_urgent = "#191513"
theme.bg_minimize = "#191513"
theme.bg_dark = "#191513"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#998f83"
theme.fg_focus = "#998f83"
theme.fg_urgent = "#998f83"
theme.fg_minimize = "#6b655c"

theme.useless_gap = dpi(10)
theme.border_width = dpi(0)
theme.border_color_normal = "#191513"
theme.border_color_active = "#302824"
theme.border_color_marked = "#998f83"

theme.green = "#5a7051"
theme.warn = "#777a59"
theme.critical = "#896664"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]

theme.titlebar_bg_focus = theme.bg_subtle
theme.titlebar_bg_normal = theme.bg_normal

theme.taglist_fg_empty = "#6b655c"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

theme.start_icon = icons_path .. "menu.svg"
theme.charge_icon = icons_path .. "charge.svg"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

theme.bar_status_fg = "#726b62"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua

-- Define the image to load
theme.titlebar_close_button_normal = theme_path .. "close.svg"
theme.titlebar_close_button_focus = theme_path .. "close.svg"

theme.titlebar_minimize_button_normal = theme_path .. "minimize.svg"
theme.titlebar_minimize_button_focus = theme_path .. "minimize.svg"

theme.titlebar_maximized_button_normal_inactive = theme_path .. "maximized.svg"
theme.titlebar_maximized_button_focus_inactive = theme_path .. "maximized.svg"
theme.titlebar_maximized_button_normal_active = theme_path .. "maximized.svg"
theme.titlebar_maximized_button_focus_active = theme_path .. "maximized.svg"

theme.layout_floating = gears.color.recolor_image(themes_path .. "default/layouts/floatingw.png", theme.fg_normal)
theme.layout_tile = gears.color.recolor_image(themes_path .. "default/layouts/tilew.png", theme.fg_normal)
theme.layout_max = gears.color.recolor_image(themes_path .. "default/layouts/maxw.png", theme.fg_normal)
theme.layout_tilebottom = gears.color.recolor_image(themes_path .. "default/layouts/tilebottomw.png", theme.fg_normal)
theme.layout_spiral = gears.color.recolor_image(themes_path .. "default/layouts/spiralw.png", theme.fg_normal)

theme.tag_preview_widget_border_radius = 0
theme.tag_preview_client_border_radius = 0
theme.tag_preview_client_opacity = 0.5
theme.tag_preview_client_bg = "#332b26"
theme.tag_preview_client_border_color = "#332b26"
theme.tag_preview_client_border_width = 3
theme.tag_preview_widget_bg = "#191513"
theme.tag_preview_widget_border_color = theme.bg_focus
theme.tag_preview_widget_border_width = 2
theme.tag_preview_widget_margin = 10

theme.icon_theme = nil

return theme
