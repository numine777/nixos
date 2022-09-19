local lua_settings = {
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
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
            enable = false,
        },
    },
}

local function setup(config, server)
    local util = require("lspconfig/util")

    local root_files = {
        "setup.py",
        "pyproject.toml",
        "setup.cfg",
        "requirements.txt",
        ".git",
        "BUILD.bazel",
    }
    local find_root = function(filename)
        return util.root_pattern(unpack(root_files))(filename) or util.path.dirname(filename)
    end

    if server == "bashls" then
        -- config.before_init = function(params)
        -- 	params.processId = vim.NIL
        -- end

        -- config.cmd = lspcontainers.command(server)
        -- config.root_dir = util.root_pattern(".git", vim.fn.getcwd())
    end

    if server == "ccls" then
        config.cmd = {
            "nix-shell",
            "/home/scott/nixos/config/nvim/lua/plugins/lsp-nix-shells/ccls.nix",
            "--command",
            '"ccls"',
        }
    end

    -- if server == "java_language_server" then
    --     config.cmd = { "/nix/store/5gb2d2invlqasckxd3gg5v58mp4mi2hm-java-language-server-0.2.38/share/java/java-language-server/lang_server_linux.sh" }
    -- end

    if server == "dockerls" then
        -- config.before_init = function(params)
        -- 	params.processId = vim.NIL
        -- end
        -- config.cmd = lspcontainers.command(server)
        -- config.root_dir = util.root_pattern(".git", vim.fn.getcwd())
    end

    if server == "graphql" then
        config.cmd = require("lspcontainers").command(server)
    end

    if server == "gopls" then
        config.cmd = {
            "nix-shell",
            "/home/scott/nixos/config/nvim/lua/plugins/lsp-nix-shells/gopls.nix",
            "--command",
            '"gopls"',
        }
        -- config.root_dir = util.root_pattern(".git", vim.fn.getcwd())
    end

    if server == "html" then
        -- config.cmd = lspcontainers.command(server)
    end

    if server == "jsonls" then
        -- config.before_init = function(params)
        -- 	params.processId = vim.NIL
        -- end
        -- config.cmd = lspcontainers.command(server)
        -- config.root_dir = util.root_pattern(".git", vim.fn.getcwd())
    end

    if server == "pyright" then
        config.cmd = {
            -- "nix-shell",
            -- "/home/scott/nixos/config/nvim/lua/plugins/lsp-nix-shells/pyright.nix",
            -- "--command",
            "pyright-langserver", "--stdio",
        }
        config.root_dir = find_root
        -- config.root_dir = util.root_pattern(".git", vim.fn.getcwd())
    end

    if server == "sumneko_lua" then
        config.cmd = {
            "nix-shell",
            "/home/scott/nixos/config/nvim/lua/plugins/lsp-nix-shells/sumneko_lua.nix",
            "--run",
            '"lua-language-server"',
        }
        config.settings = lua_settings
    end

    if server == "rust_analyzer" then
        config.cmd = {
            "nix-shell",
            "/home/scott/nixos/config/nvim/lua/plugins/lsp-nix-shells/rust_analyzer.nix",
            "--command",
            '"rust-analyzer"',
        }
        config.settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    overrideCommand = { "cargo", "clippy", "--", "-W", "clippy::pedantic" },
                },
            },
        }
        -- local PATH = string.match(debug.getinfo(1,"S").source, "^@(.+/)[%a%-%d_]+%.lua$")
        -- config.cmd = {
        -- 	"nix-shell",
        -- 	PATH .. "/plugins/lsp-nix-shells/rust_analyzer.nix",
        -- 	"--run",
        -- 	'"rust-analyzer"',
        -- }
        -- config.root_dir = util.root_pattern(".git", "Cargo.toml", vim.fn.getcwd())

        -- vim.api.nvim_exec(
        -- 	[[
        --   autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', highlight = "NonText", enabled = {"TypeHint", "ChainingHint", "ParameterHint" } }
        -- ]],
        -- 	false
        -- )
    end

    if server == "terraformls" then
        config.cmd = {
            -- "nix-shell",
            -- "--pure",
            -- "/home/scott/nixos/config/nvim/lua/plugins/lsp-nix-shells/terraform.nix",
            -- "--command",
            -- [["terraform-ls serve"]],
            "terraform-ls", "serve"
        }

        config.filetypes = { "hcl", "tf", "terraform", "tfvars" }
    end

    if server == "tsserver" then
        config.cmd = {
            -- "nix-shell",
            -- "/home/scott/nixos/config/nvim/lua/plugins/lsp-nix-shells/typescript.nix",
            -- "--run",
            "typescript-language-server", "--stdio",
        }
        -- config.before_init = function(params)
        -- 	params.processId = vim.NIL
        -- end

        config.root_dir = util.root_pattern(".git", "package.json", vim.fn.getcwd())
    end

    if server == "yamlls" then
        -- config.before_init = function(params)
        -- 	params.processId = vim.NIL
        -- end

        -- config.cmd = lspcontainers.command(server)
        -- config.root_dir = util.root_pattern(".git", vim.fn.getcwd())
    end
end

return {
    setup = setup,
}
