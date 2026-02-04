-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local alpha = function()
  return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smoothscroll = false
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.autoformat = false
vim.o.guifont = "BerkeleyMono Nerd Font:h20"
vim.g.snacks_animate = false
vim.g.neovide_window_blurred = true
vim.g.neovide_opacity = 0.5
vim.g.transparency = 0.9
vim.g.neovide_detach_on_quit = 'always_detach'
-- vim.opt.clipboard = ""
-- vim.opt.guicursor = ""
-- vim.g.neovide_background_color = "#111111" .. alpha()
