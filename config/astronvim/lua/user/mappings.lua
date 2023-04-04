vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

local builtin = require('telescope.builtin')
local function find_project_files(opts)
    opts = opts or {}
    local ok = pcall(builtin.git_files, opts)
    if not ok then
        builtin.find_files(opts)
    end
end
-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          require("astronvim.utils.buffer").close(
            bufnr)
        end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["J"] = { "mzJ`z" },
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    ["n"] = { "nzzzv" },
    ["N"] = { "Nzzzv" },
    ["Q"] = { "<nop>" },
    ["<C-f>"] = { "<cmd>silent !tmux neww tmux-sessionizer<CR>" },
    ["<C-k>"] = { "<cmd>cnext<CR>zz" },
    ["<C-j>"] = { "<cmd>cprev<CR>zz" },
    ["<C-q>"] = { "<cmd>call QuickFixToggle()<CR>" },
    ["<leader>k"] = { "<cmd>lnext<CR>zz" },
    ["<leader>j"] = { "<cmd>lprev<CR>zz" },
    ["<leader>s"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]] },
    ["<leader>y"] = { [["+y]] },
    ["<leader>Y"] = { [["+Y]] },
    ["<leader>a"] = { require("harpoon.mark").add_file },
    ["<C-e>"] = { require("harpoon.ui").toggle_quick_menu },
    ["<C-h>"] = { function() require("harpoon.ui").nav_file(1) end },
    ["<C-t>"] = { function() require("harpoon.ui").nav_file(2) end },
    ["<C-n>"] = { function() require("harpoon.ui").nav_file(3) end },
    ["<C-s>"] = { function() require("harpoon.ui").nav_file(4) end },
    ['<C-p>'] = { find_project_files },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv" },
    ["K"] = { ":m '<-2<CR>gv=gv" },
    ["<"] = { "<gv" },
    [">"] = { ">gv" },
    ["<leader>y"] = { [["+y]] },
    ["<leader>d"] = { [["_d]] },
  },
  x = {
    -- greatest remap ever
    ["<leader>p"] = { [["_dP]] },
  },
  i = {
    -- This is going to get me cancelled
    ["<C-c>"] = { "<Esc>" },
  }
}
