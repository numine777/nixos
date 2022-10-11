local augroup = vim.api.nvim_create_augroup
NumineGroup = augroup("Numine", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufEnter", "BufWinEnter", "TabEnter" }, {
	group = NumineGroup,
	pattern = "*.rs",
	callback = function()
		require("lsp_extensions").inlay_hints({})
	end,
})

autocmd({ "BufWritePre" }, {
	group = NumineGroup,
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

autocmd({ "BufNewFile", "BufRead" }, {
	group = NumineGroup,
	pattern = "*Jenkinsfile",
	command = ":set ft=groovy",
})

autocmd({ "BufNewFile", "BufRead" }, {
	group = NumineGroup,
	pattern = "*.gradle",
	command = ":set ft=java",
})

autocmd({ "BufNewFile", "BufRead" }, {
	group = NumineGroup,
	pattern = { "*.bazel.tpl", "*.bzl*" },
	command = ":set ft=bzl",
})

autocmd({ "BufNewFile", "BufRead" }, {
	group = NumineGroup,
	pattern = "CMakeLists*",
	command = ":set ft=cmake",
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		require("numine.colors").ColorMyPencils()
	end,
})
