lvim.plugins = {
	{
		-- { "akinsho/flutter-tools.nvim", commit = "d9697b913a7e199e48b09403755774bed7063a90" },
		"ThePrimeagen/git-worktree.nvim",
		"tpope/vim-fugitive",
		"mbbill/undotree",
		{
			"ThePrimeagen/harpoon",
			config = function()
				-- Harpoon settings
				require("harpoon").setup({
					nav_first_in_list = true,
				})
			end,
		},
		{
			"Shatur/neovim-cmake",
			config = function()
				require("cmake").setup({})
			end,
		},
		"mtth/scratch.vim",
		"Shatur/neovim-ayu",
		"romgrk/nvim-treesitter-context",
		{ "npxbr/gruvbox.nvim", dependencies = { "rktjmp/lush.nvim" } },
		"shaunsingh/nord.nvim",
		"tjdevries/gruvbuddy.nvim",
		"tjdevries/colorbuddy.nvim",
		{ "norcalli/nvim-colorizer.lua" },
		{
			"rose-pine/neovim",
			name = "rose-pine",
			config = function()
				require("configs.rosepine")
			end,
		},
		-- "folke/tokyonight.nvim",
		{
			"catppuccin/nvim",
			name = "catppuccin",
			config = function()
				require("catppuccin").setup()
			end,
		},
		{ "tzachar/cmp-tabnine", build = "./install.sh", dependencies = "hrsh7th/nvim-cmp" },
		{
			"zbirenbaum/copilot.lua",
			-- event = { "VimEnter" },
			config = function()
				vim.defer_fn(function()
					require("copilot").setup({
						plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
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
	},
}

lvim.builtin.telescope.on_config_done = function(telescope)
	pcall(telescope.load_extension, "git_worktree")
	require("configs.telescope")
end
