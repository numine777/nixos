require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = require("telescope.actions").cycle_history_next,
				["<C-k>"] = require("telescope.actions").cycle_history_prev,
			},
		},
	},
	pickers = {
		git_files = {
			hidden = true,
			show_untracked = true,
		},
	},
})
