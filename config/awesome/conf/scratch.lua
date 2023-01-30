local bling = require "modules.bling"

Scratch = {}

Scratch.term = bling.module.scratchpad {
  command = "nixGLNvidia-470-141.03 kitty --class=scratch",
  rule = { instance = "scratch" },
  sticky = true,
  autoclose = false,
  floating = true,
  geometry = { x = 850, y = 450, height = 300, width = 500 },
  reapply = true,
  dont_focus_before_close = false,
}
