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
	{ exe = "nixpkgs-fmt", filetypes = { "nix" } },
})

local root_files = {
	"tsconfig.json",
	".eslintrc.js",
	"package.json",
	".git",
	"Podfile",
	"BUILD.bazel",
	-- "WORKSPACE",
	"Cargo.toml",
	"CMakeList.txt",
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
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer", "clangd", "rnix-lsp", "pyright" })
local function config(_config)
	return vim.tbl_deep_extend("force", {
		root_dir = function(filename)
			return util.root_pattern(unpack(root_files))(filename) or util.path.dirname(filename)
		end,
	}, _config or {})
end

local manager = require("lvim.lsp.manager")
manager.setup(
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

manager.setup("pyright", config({}))
manager.setup("sourcekit", config())
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

require("lvim.lsp.manager").setup("clangd", config(opts))
