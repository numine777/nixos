-- lua/plugins/init.lua

-- {{{ bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd("packadd packer.nvim")
end
-- }}}

vim.cmd([[packadd packer.nvim]])

require("packer").startup({
	function(use)
		-- Core ----------------------------------------------------
		use({ "wbthomason/packer.nvim", opt = true })
		use({ "nvim-lua/plenary.nvim", module_pattern = "plenary.*" })
		use({ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" })

		-- Colorschemes --------------------------------------------
		use("sainnhe/gruvbox-material")
		use("folke/tokyonight.nvim")
		use("shaunsingh/nord.nvim")
		use("b4skyx/serenade")
		use("mcchrish/zenbones.nvim")
		use("rktjmp/lush.nvim")
		use("RRethy/nvim-base16") -- for base16 colorschemes

		-- UI ------------------------------------------------------

		use({
			"ThePrimeagen/harpoon",
			config = function()
				require("harpoon").setup({
					nav_first_in_line = true,
				})
			end,
		})

		use({
			"rcarriga/nvim-notify",
			config = function()
				require("plugins.notify").setup()
			end,
			requires = { "nvim-telescope/telescope.nvim" },
		})
		use({ "Tastyep/structlog.nvim" })
		use({
			"akinsho/toggleterm.nvim",
			event = "BufWinEnter",
			branch = "main",
			config = function()
				require("plugins.terminal").setup()
			end,
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			event = "VimEnter",
			config = [[require"plugins.telescope"]],
			requires = {
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				{ "nvim-telescope/telescope-file-browser.nvim" },
				{ "nvim-telescope/telescope-live-grep-raw.nvim" },
			},
		})

		--  LSP ----------------------------------------------------
		use({
			"jose-elias-alvarez/null-ls.nvim",
			module = "null-ls",
			after = "nvim-lspconfig",
		})
		use({
			"folke/trouble.nvim",
			after = "nvim-lspconfig",
			cmd = { "Trouble", "TroubleToggle" },
			config = function()
				require("trouble").setup({
					auto_close = true,
				})
			end,
		})
		use({
			"lspcontainers/lspcontainers.nvim",
			requires = {
				"neovim/nvim-lspconfig",
				"nvim-lua/lsp_extensions.nvim",
			},
			config = function()
				require("lspcontainers").setup({
					ensure_installed = {
						"bashls",
						"dockerls",
						"gopls",
						"html",
						"pyright",
						"rust_analyzer",
						"sumneko_lua",
						"terraformls",
						"tsserver",
						"yamlls",
					},
				})

				require("plugins.lspconfig").init()
			end,
		})

		-- Treesitter ----------------------------------------------
		use({
			"nvim-treesitter/nvim-treesitter",
			config = [[require "plugins.treesitter"]],
			requires = {
				{ "nvim-treesitter/nvim-treesitter-textobjects" },
				{ "windwp/nvim-ts-autotag" },
				{ "JoosepAlviste/nvim-ts-context-commentstring" },
				{
					"nvim-treesitter/playground",
					keys = { "<localleader>s" },
					cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
					config = function()
						utils.nnoremap({
							",s", "<CMD>TSHighlightCapturesUnderCursor<CR>", {}
						})
					end,
				},
			},
		})
		use({ "romgrk/nvim-treesitter-context" })

		-- Completion and Snippets ---------------------------------
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-vsnip",
				"hrsh7th/vim-vsnip",
				"ray-x/cmp-treesitter",
				{
					"tzachar/cmp-tabnine",
					run = "./install.sh",
				},
				"onsails/lspkind-nvim",
			},
			config = function()
				require("plugins.cmp").init()
				require("plugins.cmp_tabnine").init()
				require("plugins.lsp_kind").init()
			end,
		})
		use({
			-- you gotta love them snippets
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
			config = [[require("plugins.snippets")]],
		})
		-- this completes me
		use({
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			module = "nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({
					close_triple_quotes = true,
				})
			end,
		})

		-- Git -----------------------------------------------------
		use({
			"lewis6991/gitsigns.nvim",
			event = "BufRead",
			module = "gitsigns",
			config = [[require("plugins.gitsigns")]],
		})
		use({ "ThePrimeagen/git-worktree.nvim" })

		-- comments are nice
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		-- todo comments
		use({
			"folke/todo-comments.nvim",
			event = "BufRead",
			config = function()
				require("todo-comments").setup({
					signs = false,
					colors = {
						error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#ea6962" },
						warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#d8a657" },
						info = { "LspDiagnosticsDefaultInformation", "#a9b665" },
						hint = { "LspDiagnosticsDefaultHint", "#89b482" },
						default = { "Identifier", "#7daea3" },
					},
				})
			end,
		})

		-- highlight colors
		use({
			"norcalli/nvim-colorizer.lua",
			cmd = { "ColorizerToggle" },
			keys = { "<leader>tc" },
			config = function()
				require("colorizer").setup({ "*" }, {
					names = false,
					mode = "background",
				})
			end,
		})
	end,

	-- packer config
	log = { level = "info" },
	config = {
		display = {
			prompt_border = "single",
		},
		profile = {
			enable = true,
			threshold = 0,
		},
	},
})
