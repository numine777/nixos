local awful = require "awful"
local bling = require "modules.bling"
local l = awful.layout.suit

awful.layout.layouts = {
  l.spiral,
  l.floating,
  l.tile,
  l.tile.bottom,
  bling.layout.mstab,
  bling.layout.centered,
  bling.layout.equalarea,
  bling.layout.deck,
}
