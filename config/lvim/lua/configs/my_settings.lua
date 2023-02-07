CACHE_PATH = vim.fn.stdpath("cache")

-- general
lvim.log.level = "warn"
lvim.transparent_window = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamed"
vim.opt.timeoutlen = 200
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.showtabline = 1
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_localrmdir = "rm -rf"
vim.opt.laststatus = 3

lvim.leader = "space"

vim.g.tokyonight_style = "storm"
vim.g.catppuccin_flavor = "mocha"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Load the colorscheme
lvim.colorscheme = "rose-pine"
lvim.builtin.lualine.options.theme = "rose-pine"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.terminal.active = true
lvim.builtin.autopairs.active = false
-- lvim.builtin.notify.active = false
lvim.builtin.dap.active = true
lvim.builtin.bufferline.active = false
lvim.builtin.project.active = false
lvim.builtin.nvimtree.active = false
lvim.builtin.terminal.active = false
lvim.builtin.terminal.open_mapping = [[c-\]]
local actions = require("lir.actions")
local mark_actions = require("lir.mark.actions")
local clipboard_actions = require("lir.clipboard.actions")

lvim.builtin.lir.mappings = {
	["l"] = actions.edit,
	["<C-s>"] = actions.split,
	["<C-v>"] = actions.vsplit,
	-- ["<C-t>"] = actions.tabedit,

	["h"] = actions.up,
	["q"] = actions.quit,

	["d"] = actions.mkdir,
	["%"] = actions.newfile,
	["R"] = actions.rename,
	["@"] = actions.cd,
	["Y"] = actions.yank_path,
	["."] = actions.toggle_show_hidden,
	["D"] = actions.delete,

	["J"] = function()
		mark_actions.toggle_mark()
		vim.cmd("normal! j")
	end,
	["C"] = clipboard_actions.copy,
	["X"] = clipboard_actions.cut,
	["P"] = clipboard_actions.paste,
}
-- lvim.builtin.nvimtree.setup.view.side = "left"

-- if you don't want all the parsers change this to a table of the ones you want
-- lvim.builtin.treesitter.ensure_installed = {
-- 	"bash",
-- 	"c",
-- 	"cpp",
-- 	"javascript",
-- 	"json",
-- 	"lua",
-- 	"python",
-- 	"typescript",
-- 	"css",
-- 	"rust",
-- 	"java",
-- 	"yaml",
-- }

-- lvim.builtin.treesitter.ignore_install = { "haskell", "elisp" }
lvim.builtin.treesitter.ignore_install = "all"
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
	{ exe = "buildifier", filetypes = { "bzl" } },
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
	"CMakeList.txt",
	"pyproject.toml",
    "Cargo.toml",
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
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer", "clangd", "rnix-lsp" })
local function config(_config)
	return vim.tbl_deep_extend("force", {
		-- capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		root_dir = function(filename)
			return util.root_pattern(unpack(root_files))(filename) or util.path.dirname(filename)
		end,
	}, _config or {})
end

require("lvim.lsp.manager").setup(
	"rust_analyzer",
	config({
		cmd = { "rustup", "run", "nightly", "rust-analyzer" },
		--[[
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
        },
    }
    --]]
	})
)
require("lvim.lsp.manager").setup("pyright", config())
require("lvim.lsp.manager").setup("rnix", config())
require("lvim.lsp.manager").setup("gopls", config())
-- some settings can only passed as commandline flags `clangd --help`
local clangd_flags = {
	"--all-scopes-completion",
	"--suggest-missing-includes",
	"--background-index",
	"--pch-storage=disk",
	"--cross-file-rename",
	"--log=info",
	"--completion-style=detailed",
	"--enable-config", -- clangd 11+ supports reading from .clangd configuration file
	"--clang-tidy",
	-- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
	-- "--fallback-style=Google",
	-- "--header-insertion=never",
	-- "--query-driver=<list-of-white-listed-complers>"
}

local clangd_bin = "clangd"

local custom_on_attach = function(client, bufnr)
	require("lvim.lsp").common_on_attach(client, bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end

local opts = {
	cmd = { clangd_bin, unpack(clangd_flags) },
	on_attach = custom_on_attach,
}

require("lvim.lsp.manager").setup("clangd", opts)

lvim.autocommands = {
	{ { "BufNewFile", "BufRead" }, {
		pattern = { "*Jenkinsfile" },
		command = ":set ft=groovy",
	} },
	{
		"TextYankPost",
		{
			pattern = "*",
			callback = function()
				vim.highlight.on_yank({
					highgroup = "IncSearch",
					timeout = 40,
				})
			end,
		},
	},
	{
		"ColorScheme",
		{
			pattern = "*",
			callback = function()
				require("configs.colors").ColorMyPencils()
			end,
		},
	},
}

lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })
