vim.g.numine_colorscheme = "gruvbox"
local M = {}

require("tokyonight").setup({
	transparent = true,
})

function ColorMyPencils()
	vim.g.gruvbox_contrast_dark = "hard"
	vim.g.gruvbox_invert_selection = "0"
	vim.g.tokyonight_transparent_sidebar = true
	vim.g.tokyonight_transparent = true
	vim.opt.background = "dark"

	lvim.colorscheme = vim.g.numine_colorscheme
	lvim.builtin.lualine.options.theme = vim.g.numine_colorscheme
	vim.cmd("colorscheme " .. vim.g.numine_colorscheme)

	local hl = function(thing, opts)
		vim.api.nvim_set_hl(0, thing, opts)
	end

	hl("SignColumn", {
		bg = "none",
	})

	hl("ColorColumn", {
		ctermbg = 0,
		bg = "#555555",
	})

	hl("CursorLineNR", {
		bg = "None",
	})

	hl("Normal", {
		bg = "none",
	})

	hl("LineNr", {
		fg = "#5eacd3",
	})

	hl("netrwDir", {
		fg = "#5eacd3",
	})

	hl("WinSeparator", { background = nil })
end
M.ColorMyPencils = ColorMyPencils
return M
