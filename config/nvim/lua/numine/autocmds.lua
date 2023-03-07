local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local NumineGroup = augroup("Numine", {})

local yank_group = augroup("HighlightYank", {})
local ColorGroup = augroup("Colors", {})

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

-- autocmd({ "BufEnter", "BufWinEnter", "TabEnter" }, {
-- 	group = NumineGroup,
-- 	pattern = "*.rs",
-- 	callback = function()
-- 		require("lsp_extensions").inlay_hints({})
-- 	end,
-- })

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

autocmd("ColorScheme", {
    group = ColorGroup,
	pattern = "*",
	callback = function()
		require("numine.colors").ColorMyPencils()
	end,
})
