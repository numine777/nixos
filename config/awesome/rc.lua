require "awful.autofocus"
local naughty = require "naughty"

naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message,
  }
end)

local beautiful = require("beautiful")
local config_dir = require("gears").filesystem.get_configuration_dir()
beautiful.init(config_dir .. "themes/forest/theme.lua")
beautiful.wallpaper = config_dir .. "themes/forest/forest.jpg"
for s in screen do
  require("awful").wallpaper {
    screen = s,
    -- widget = {
    --   {
    --     image = require("beautiful").wallpaper,
    --     resize = true,
    --     widget = require("wibox").widget.imagebox,
    --   },
    --   valign = "center",
    --   halign = "center",
    --   tiled = false,
    --   widget = require("wibox").container.tile,
    -- },
    widget = {
      horizontal_fit_policy = "fit",
      vertical_fit_policy = "fit",
      image = beautiful.wallpaper,
      widget = require("wibox").widget.imagebox,
    },
  }
  -- require("gears").wallpaper.maximized("themes/forest/forest.jpg", s)
end

F = {}

require "squeals"
require "conf"

require "ui.action"
require "ui.bar"
require "ui.exec"
require "ui.exit"
require "ui.notifs"
require "ui.run"
require "ui.scr"
require "ui.start"
require "ui.titlebar"
