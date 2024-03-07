require("numine.set")
require("numine.remap")

require("numine.lazy_init")

local augroup = vim.api.nvim_create_augroup
local NumineGroup = augroup('Numine', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = NumineGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
    group = NumineGroup,
    callback = require("numine.utils").on_attach,
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

autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "Podfile", "Gemfile", "Gymfile", "Fastfile", "Appfile", "Matchfile", "Pluginfile" },
	command = ":set ft=ruby",
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
