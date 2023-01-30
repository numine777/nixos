local init = function()
    local lsp = require("lsp-zero")
    lsp.preset("recommended")

    lsp.set_preferences({
        set_lsp_keymaps = false, -- set to false if you want to configure your own keybindings
        manage_nvim_cmp = false, -- set to false if you want to configure nvim-cmp on your own
    })
    -- (Optional) Configure lua language server for neovim
    lsp.nvim_workspace()

    lsp.setup()
    local Remap = require("numine.mapper")
    local nnoremap = Remap.nnoremap
    local inoremap = Remap.inoremap
    -- local sumneko_root_path = "/home/mpaulson/personal/sumneko"
    -- local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require("copilot").setup()
    require("copilot_cmp").setup()
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
            on_attach = function()
                nnoremap("gd", function()
                    vim.lsp.buf.definition()
                end)
                nnoremap("K", function()
                    vim.lsp.buf.hover()
                end)
                -- nnoremap("<leader>lws", function()
                --     vim.lsp.buf.workspace_symbol()
                -- end)
                nnoremap("gl", function()
                    vim.diagnostic.open_float()
                end)
                nnoremap("lj", function()
                    vim.diagnostic.goto_next()
                end)
                nnoremap("lk", function()
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

    require("lspconfig").nil_ls.setup(config({}))
    require("lspconfig").bashls.setup(config({}))
    require("lspconfig").yamlls.setup(config({}))

    local default_workspace = {
        library = {
            vim.fn.expand("$VIMRUNTIME"),
            "$HOME/.config/nvim",
            require("neodev.config").types(),
            "${3rd}/busted/library",
            "${3rd}/luassert/library",
        },

        maxPreload = 5000,
        preloadFileSize = 10000,
    }

    local add_packages_to_workspace = function(packages, config_)
        -- config.settings.Lua = config.settings.Lua or { workspace = default_workspace }
        local runtimedirs = vim.api.nvim__get_runtime({ "lua" }, true, { is_lua = true })
        local workspace = config_.settings.Lua.workspace
        for _, v in pairs(runtimedirs) do
            for _, pack in ipairs(packages) do
                if v:match(pack) and not vim.tbl_contains(workspace.library, v) then
                    table.insert(workspace.library, v)
                end
            end
        end
    end

    local lspconfig = require("lspconfig")

    local make_on_new_config = function(on_new_config, _)
        return lspconfig.util.add_hook_before(on_new_config, function(new_config, _)
            local server_name = new_config.name

            if server_name ~= "sumneko_lua" then
                return
            end
            local plugins = { "plenary.nvim", "telescope.nvim", "nvim-treesitter", "LuaSnip" }
            add_packages_to_workspace(plugins, new_config)
        end)
    end

    lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
        on_new_config = make_on_new_config(lspconfig.util.default_config.on_new_config),
    })

    local lua_opts = {
        settings = {
            Lua = {
                telemetry = { enable = false },
                runtime = {
                    version = "LuaJIT",
                    special = {
                        reload = "require",
                    },
                },
                diagnostics = {
                    globals = { "vim", "packer_plugins", "reload" },
                },
                workspace = default_workspace,
            },
        },
    }

    require("lspconfig").sumneko_lua.setup(config(lua_opts))

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

    local root_files = {
        "tsconfig.json",
        ".eslintrc.js",
        "package.json",
        ".git",
        "BUILD.bazel",
        "CMakeList.txt",
        "Makefile",
    }
    -- local util = require("lspconfig.util")
    require("null-ls").setup({
        sources = {
            require("null-ls").builtins.formatting.stylua,
            require("null-ls").builtins.formatting.black,
            require("null-ls").builtins.formatting.prettier.with({
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
                prefer_local = "node_modules/.bin",
            }),
            require("null-ls").builtins.formatting.buildifier,
            require("null-ls").builtins.diagnostics.eslint.with({
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
                prefer_local = "node_modules/.bin",
            }),
            require("null-ls").builtins.completion.spell,
        },
        root_dir = require("null-ls.utils").root_pattern(root_files),
    })

    require("numine.breadcrumbs").setup()
end

if not vim.g.vscode then
    init()
end
