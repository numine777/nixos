return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "nvimtools/none-ls.nvim",
        "jose-elias-alvarez/typescript.nvim",
        "pmizio/typescript-tools.nvim",
    },

    config = function()
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

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local util = require("lspconfig/util")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "lua_ls",
                "rnix",
                "nil_ls",
                "pyright",
                "rust_analyzer",
                -- replaced by typescript-tools
                -- "tsserver",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                        root_dir = function(filename)
                            local root = util.root_pattern(unpack(root_files))(filename)
                            if root == nil then
                                print("no root found")
                                root = util.path.dirname(filename)
                            end
                            return root
                        end,
                    }
                end,

                ["pyright"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup {
                        capabilities = capabilities,
                        root_dir = function(filename)
                            local root = util.root_pattern(unpack(root_files))(filename)
                            if root == nil then
                                print("pyright: no root found")
                                root = util.path.dirname(filename)
                            end
                            return root
                        end,
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        require("typescript-tools").setup({
            on_attach = require("numine.utils").on_attach,
            capabilities = capabilities,
        })

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
                { name = 'path' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        local none_ls = require("null-ls")
        local find_cwd = function(params)
			local root = util.root_pattern(unpack(root_files))(params.bufname) or util.path.dirname(params.bufname)
            return root
        end

        none_ls.setup({
            sources = {
                none_ls.builtins.formatting.stylua,
                none_ls.builtins.formatting.prettier.with({
                    prefer_local = "parksmarter/node_modules/.bin",
                    cwd = find_cwd,
                }),
                none_ls.builtins.formatting.nixpkgs_fmt,
                none_ls.builtins.formatting.buildifier,
                none_ls.builtins.formatting.yapf,
                none_ls.builtins.diagnostics.eslint_d.with({
                    -- prefer_local = "parksmarter/node_modules/.bin",
                    cwd = find_cwd,
                }),
                none_ls.builtins.completion.spell,
                require("typescript.extensions.null-ls.code-actions"),
            },
        })
    end
}
