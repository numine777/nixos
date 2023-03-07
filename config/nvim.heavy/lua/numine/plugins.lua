local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct
return require("lazy").setup({
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require("numine.rosepine").config()
        end
    },
    "tjdevries/gruvbuddy.nvim",
    "tjdevries/colorbuddy.nvim",
    "sbdchd/neoformat",

    -- Simple plugins can be specified as strings
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",

    -- TJ created lodash of neovim
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope.nvim",

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
    },

    -- All the things
    "simrat39/symbols-outline.nvim",
    "jose-elias-alvarez/null-ls.nvim",

    -- Primeagen doesn"t create lodash
    "ThePrimeagen/git-worktree.nvim",
    "ThePrimeagen/harpoon",
    "ThePrimeagen/refactoring.nvim",

    "mbbill/undotree",

    -- Colorscheme section
    "gruvbox-community/gruvbox",
    "folke/tokyonight.nvim",

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    "nvim-treesitter/playground",
    "romgrk/nvim-treesitter-context",
    "tamago324/lir.nvim",
    "folke/neodev.nvim",

    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    {
        "xbase-lab/xbase",
        build = "make install", -- make free_space (not recommended, longer build time)
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("xbase").setup({}) -- see default configuration bellow
        end,
    },
    {
        "kevinhwang91/nvim-bqf",
        -- event = { "BufRead", "BufNew" },
        config = function()
            require("bqf").setup({
                auto_enable = true,
                preview = {
                    win_height = 12,
                    win_vheight = 12,
                    delay_syntax = 80,
                    border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
                },
                func_map = {
                    vsplit = "",
                    ptogglemode = "z,",
                    stoggleup = "",
                },
                filter = {
                    fzf = {
                        action_for = { ["ctrl-s"] = "split" },
                        extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
                    },
                },
            })
        end,
    },
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = function()
            require("git-conflict").setup()
        end,
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional
            { "tzachar/cmp-tabnine", build = "./install.sh" },

            -- Snippets
            { "L3MON4D3/LuaSnip" }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
    },
    {
        "zbirenbaum/copilot.lua",
        -- event = { "VimEnter" },
        config = function()
            vim.defer_fn(function()
                require("copilot").setup({
                    plugin_manager_path = vim.fn.stdpath("data") .. "/lazy",
                })
            end, 100)
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "copilot.lua", "nvim-cmp" },
        config = function()
            require("copilot_cmp").setup()
        end,
    },
})
