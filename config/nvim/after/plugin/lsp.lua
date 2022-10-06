local Remap = require("numine.mapper")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

-- local sumneko_root_path = "/home/mpaulson/personal/sumneko"
-- local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
})

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			nnoremap("gd", function()
				vim.lsp.buf.definition()
			end)
			nnoremap("K", function()
				vim.lsp.buf.hover()
			end)
			nnoremap("<leader>lws", function()
				vim.lsp.buf.workspace_symbol()
			end)
			nnoremap("gl", function()
				vim.diagnostic.open_float()
			end)
			nnoremap("[d", function()
				vim.diagnostic.goto_next()
			end)
			nnoremap("]d", function()
				vim.diagnostic.goto_prev()
			end)
			nnoremap("<leader>la", function()
				vim.lsp.buf.code_action()
			end)
			nnoremap("<leader>lo", function()
				vim.lsp.buf.code_action({
					filter = function(code_action)
						if not code_action or not code_action.data then
							return false
						end

						local data = code_action.data.id
						return string.sub(data, #data - 1, #data) == ":0"
					end,
					apply = true,
				})
			end)
			nnoremap("gr", function()
				vim.lsp.buf.references()
			end)
			nnoremap("<leader>lr", function()
				vim.lsp.buf.rename()
			end)
			inoremap("<C-h>", function()
				vim.lsp.buf.signature_help()
			end)
		end,
	}, _config or {})
end

require("lspconfig").zls.setup(config())

require("lspconfig").tsserver.setup(config())

require("lspconfig").ccls.setup(config({
	cmd = {
		"ccls",
		'--init={"index": {"threads": 8}}',
	},
}))

require("lspconfig").pyright.setup(config())

require("lspconfig").cssls.setup(config())

require("lspconfig").gopls.setup(config({
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}))

-- who even uses this?
require("lspconfig").rust_analyzer.setup(config({
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
}))

require'lspconfig'.rnix.setup(config({}))

require("lspconfig").sumneko_lua.setup(config({
	-- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
}))

local opts = {
	-- whether to highlight the currently hovered symbol
	-- disable if your cpu usage is higher than you want it
	-- or you just hate the highlight
	-- default: true
	highlight_hovered_item = true,

	-- whether to show outline guides
	-- default: true
	show_guides = true,
}

require("symbols-outline").setup(opts)

local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.vim/plugged/"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})

require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.formatting.buildifier,
		require("null-ls").builtins.diagnostics.eslint,
		require("null-ls").builtins.completion.spell,
	},
})
