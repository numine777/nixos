-- vim options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
lvim.transparent_window = true
vim.opt.clipboard = "unnamed"
vim.opt.timeoutlen = 200
vim.opt.guicursor = ""
vim.opt.colorcolumn = "80"

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	pattern = "*.lua",
	timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.autopairs.active = false
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = false
lvim.builtin.treesitter.parser_install_dir = vim.fn.stdpath("data") .. "/nvim/site/parser"
require("numine")
