if not vim.g.vscode then
    local lsp = require("lsp-zero")

    lsp.preset("recommended")

    lsp.ensure_installed({
        "tsserver",
        -- 'rust_analyzer',
    })

    -- Fix Undefined global 'vim'
    lsp.configure("lua-language-server", {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
    })

    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local cmp_mappings = lsp.defaults.cmp_mappings({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    })

    cmp_mappings["<Tab>"] = nil
    cmp_mappings["<S-Tab>"] = nil

    lsp.setup_nvim_cmp({
        mapping = cmp_mappings,
    })

    lsp.set_preferences({
        suggest_lsp_servers = false,
        sign_icons = {
            error = "E",
            warn = "W",
            hint = "H",
            info = "I",
        },
    })

    local root_files = {
        "tsconfig.json",
        ".eslintrc.js",
        "package.json",
        ".git",
        "BUILD.bazel",
        "CMakeList.txt",
        "Makefile",
        "Cargo.toml",
    }

    local util = require("lspconfig/util")
    local function _on_attach(opts)
        vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "gl", function()
            vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "<leader>lj", function()
            vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "<leader>lk", function()
            vim.diagnostic.goto_prev()
        end, opts)
        vim.keymap.set("n", "<leader>la", function()
            vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "<leader>lo", function()
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
        end, opts)
        vim.keymap.set("n", "gr", function()
            vim.lsp.buf.references()
        end, opts)
        vim.keymap.set("n", "<leader>lr", function()
            vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set("i", "<C-h>", function()
            vim.lsp.buf.signature_help()
        end, opts)
    end

    local function config(_config)
        return vim.tbl_deep_extend("force", {
            root_dir = function(filename)
                return util.root_pattern(unpack(root_files))(filename) or util.path.dirname(filename)
            end,
            on_attach = _on_attach(opts),
        }, _config or {})
    end

    local function setup_document_symbols(client, bufnr)
        vim.g.navic_silence = false -- can be set to true to suppress error
        local symbols_supported = client.supports_method("textDocument/documentSymbol")
        if not symbols_supported then
            return
        end
        local status_ok, navic = pcall(require, "nvim-navic")
        if status_ok then
            navic.attach(client, bufnr)
        end
    end

    lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        setup_document_symbols(client, bufnr)
        _on_attach(opts)
    end)

    lsp.configure(
        "rust_analyzer",
        config({
            cmd = { "rustup", "run", "nightly", "rust-analyzer" },
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy",
                    },
                },
            },
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

    lsp.configure(
        "bzl",
        config({
            config({
                cmd = { "bzl", "lsp" },
                filetypes = { "bzl" },
            }),
        })
    )
    lsp.setup()

    vim.diagnostic.config({
        virtual_text = true,
    })

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
end
