-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local NumineGroup = augroup("Numine", {})
local ColorGroup = augroup("Colors", {})

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

-- autocmd("ColorScheme", {
--   group = ColorGroup,
--   pattern = "*",
--   callback = function()
--     require("utils.colors").ColorMyPencils()
--   end,
-- })
