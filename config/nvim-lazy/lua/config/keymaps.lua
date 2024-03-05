-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- General
-- vim.keymap.set("n", "<leader>e", ":Ex<CR>")
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h>", function()
  ui.nav_file(1)
end)
vim.keymap.set("n", "<C-t>", function()
  ui.nav_file(2)
end)
vim.keymap.set("n", "<C-n>", function()
  ui.nav_file(3)
end)
vim.keymap.set("n", "<C-s>", function()
  ui.nav_file(4)
end)

-- Telescope
local builtin = require("telescope.builtin")

local function search_dotfiles()
  require("telescope.builtin").find_files({
    prompt_title = "< VimRC >",
    cwd = vim.env.NVIM_DOTFILES,
    hidden = true,
  })
end

local function find_project_files(opts)
  opts = opts or {}
  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end
vim.keymap.set("n", "<leader>sd", search_dotfiles, {})
vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", find_project_files, {})
vim.keymap.set("n", "<leader>st", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>sh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>sy", function()
  require("telescope.builtin").live_grep({ type_filter = vim.fn.input("File Type > ") })
end)

-- Git
vim.keymap.set("n", "<leader>gn", vim.cmd.Git)
vim.keymap.set("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>")
vim.keymap.set("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>")
vim.keymap.set("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>")
vim.keymap.set("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>")
vim.keymap.set("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>")
vim.keymap.set("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>")
vim.keymap.set("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>")
vim.keymap.set("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>")

-- Quickfix
vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

vim.keymap.set("n", "<C-q>", "<cmd>call QuickFixToggle()<CR>")
