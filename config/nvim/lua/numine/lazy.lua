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
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("numine.configs.statusline")
		end,
	},

	{
		"numine777/py-bazel.nvim",
		config = function()
			require("py-bazel").setup({
				library_path_marker = "python",
				pip_deps_marker = "npip",
				-- global_pyright_config = "~/.config/lvim/lsp-settings/pyright.json",
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("numine.configs.telescope")
		end,
	},

	{
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				disable_float_background = true,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		config = function()
			require("numine.configs.tokyonight")
		end,
	},

	{
		"folke/trouble.nvim",
		config = function()
			require("numine.configs.trouble")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("numine.configs.treesitter")
		end,
	},
	"nvim-treesitter/playground",
	{
		"theprimeagen/harpoon",
        branch = "harpoon2",
		config = function()
			require("numine.configs.harpoon")
		end,
	},
	"theprimeagen/refactoring.nvim",
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},
	"tpope/vim-fugitive",
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("numine.configs.git")
		end,
	},
	"nvim-treesitter/nvim-treesitter-context",
	"kevinhwang91/nvim-bqf",
    "nyoom-engineering/oxocarbon.nvim",

	"jose-elias-alvarez/null-ls.nvim",
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			require("numine.configs.lsp")
		end,
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("numine.configs.navic").setup()
		end,
	},
	"github/copilot.vim",
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	config = function()
	-- 		require("numine.configs.indent_blankline")
	-- 	end,
	-- },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("numine.configs.comment")
		end,
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			-- options
		},
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				-- Animation style (see below for details)
				stages = "fade_in_slide_out",

				-- Default timeout for notifications
				timeout = 5000,

				-- For stages that change opacity this is treated as the highlight behind the window
				background_colour = "#000000",

				-- Icons for the different levels
				icons = {
					ERROR = "",
					WARN = "",
					INFO = "",
					DEBUG = "",
					TRACE = "✎",
				},
			})
		end,
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
		},
	},
})

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
