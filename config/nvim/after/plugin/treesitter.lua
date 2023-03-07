local init = function()
	-- local parser_install_dir = vim.fn.stdpath("data") .. "/site"
	require("nvim-treesitter.configs").setup({
		-- parser_install_dir = parser_install_dir,
		parser_install_dir = nil,
		on_config_done = nil,

		-- A list of parser names, or "all"
		ensure_installed = {},

		-- List of parsers to ignore installing (for "all")
		ignore_install = {},

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		auto_install = true,

		matchup = {
			enable = false, -- mandatory, false will disable the whole extension
			-- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
		},
		highlight = {
			enable = true, -- false will disable the whole extension
			additional_vim_regex_highlighting = false,
			disable = function(lang, buf)
				if vim.tbl_contains({ "latex" }, lang) then
					return true
				end

				local status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
				return status_ok and big_file_detected
			end,
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
			config = {
				-- Languages that have a single comment style
				typescript = "// %s",
				css = "/* %s */",
				scss = "/* %s */",
				html = "<!-- %s -->",
				svelte = "<!-- %s -->",
				vue = "<!-- %s -->",
				json = "",
			},
		},
		indent = { enable = true, disable = { "yaml", "python" } },
		autotag = { enable = false },
		textobjects = {
			swap = {
				enable = false,
				-- swap_next = textobj_swap_keymaps,
			},
			-- move = textobj_move_keymaps,
			select = {
				enable = false,
				-- keymaps = textobj_sel_keymaps,
			},
		},
		textsubjects = {
			enable = false,
			keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
		},
		playground = {
			enable = false,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
		rainbow = {
			enable = false,
			extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
			max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
		},
	})
end

if not vim.g.vscode then
	init()
end
