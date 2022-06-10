CACHE_PATH = vim.fn.stdpath("cache")

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "nord"
lvim.transparent_window = true
-- lvim.builtin.nvimtree.setup.nvim_tree_ignore = {}
-- lvim.builtin.nvimtree.setup.nvim_tree_hide_dotfiles = 0
lvim.builtin.lualine.options.theme = "nord"
-- lvim.builtin.nvimtree.setup.update_cwd = false
-- lvim.builtin.nvimtree.setup.hijack_netrw = false
-- lvim.builtin.nvimtree.setup.disable_netrw = false
-- lvim.builtin.nvimtree.setup.update_to_buf_dir = {enabled = false, auto_open = false}
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamed"
vim.opt.timeoutlen = 200
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
-- vim.opt.mouse = ""
vim.opt.showtabline = 1
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_localrmdir = "rm -rf"
vim.opt.laststatus = 3
vim.api.nvim_set_hl(0, 'WinSeparator', { background = nil })

lvim.leader = "space"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.terminal.active = true
lvim.builtin.autopairs.active = true
lvim.builtin.notify.active = true
lvim.builtin.bufferline.active = false
lvim.builtin.project.active = false
lvim.builtin.nvimtree.active = false
lvim.builtin.terminal.open_mapping = [[<c-\>]]
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "cpp",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "css",
    "rust",
    "java",
    "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
    {
        exe = "prettier",
        args = { "--tab-width", "4" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
    },
    { exe = "stylua", filetypes = { "lua" } },
    -- { exe = "clang-format", filetypes = { "cpp" } },
    { exe = "black", filetypes = { "python" } },
})

local function tprint(tbl, indent)
    if not indent then
        indent = 0
    end
    local return_string = ""
    for k, v in pairs(tbl) do
        local formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            tprint(v, indent + 1)
        elseif type(v) == "boolean" then
            print(formatting .. tostring(v))
        else
            print(formatting .. v)
        end
    end
end

local root_files = {
    "tsconfig.json",
    ".eslintrc.js",
    "package.json",
    ".git",
    "BUILD.bazel",
}
local linters = require("lvim.lsp.null-ls.linters")
local util = require("lspconfig.util")
linters.setup({
    {
        exe = "eslint",
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
        cwd = function(params)
            return util.root_pattern(unpack(root_files))(params.bufname) or util.path.dirname(params.bufname)
        end,
    },
})
lvim.format_on_save = false
