local ollama_parse_curl_args = function(provider, code_opts)
    local Utils = require("avante.utils")
    local Config = require("avante.config")
    local P = require("avante.providers")
    local O = require("avante.providers.openai")

    local base, body_opts = P.parse_config(provider)

    local headers = {
        ["Content-Type"] = "application/json",
    }

    if P.env.require_api_key(base) then
        local api_key = provider.parse_api_key()
        if api_key == nil then
            error(Config.provider ..
                " API key is not set, please set it in your environment variable or config file")
        end
        headers["Authorization"] = "Bearer " .. api_key
    end

    -- NOTE: When using "o" series set the supported parameters only
    local stream = true
    body_opts.max_prompt_tokens = body_opts.max_tokens

    Utils.debug("endpoint", base.endpoint)
    Utils.debug("model", base.model)

    return {
        url = Utils.url_join(base.endpoint, "/chat/completions"),
        proxy = base.proxy,
        insecure = base.allow_insecure,
        headers = headers,
        body = vim.tbl_deep_extend("force", {
            model = base.model,
            messages = O.parse_messages(code_opts),
            stream = stream,
        }, body_opts),
    }
end

return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        dependencies = {
            "stevearc/dressing.nvim",
            "ibhagwan/fzf-lua",
        },
        opts = {
            -- Default configuration
            hints = { enabled = false },

            ---@alias AvanteProvider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
            provider = "claude",                     -- Recommend using Claude
            auto_suggestions_provider = "vllm_zeta", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
            claude = {
                endpoint = "https://api.anthropic.com",
                model = "claude-3-5-sonnet-20241022",
                temperature = 0,
                max_tokens = 4096,
            },
            vendors = {
                ollama_qwen_32 = {
                    __inherited_from = "openai",
                    api_key_name = "",
                    endpoint = "http://192.168.4.26/v1",
                    model = "qwen2.5-coder:32b",
                    max_tokens = 128000,
                    temperature = 0,
                    timeout = 30000,
                    parse_curl_args = ollama_parse_curl_args,
                },
                ollama_qwen_14 = {
                    __inherited_from = "openai",
                    api_key_name = "",
                    endpoint = "http://192.168.4.26/v1",
                    model = "qwen2.5-coder:14b",
                    max_tokens = 128000,
                    temperature = 0,
                    timeout = 30000,
                    parse_curl_args = ollama_parse_curl_args,
                },
                ollama_qwen_7 = {
                    __inherited_from = "openai",
                    api_key_name = "",
                    endpoint = "http://192.168.4.26/v1",
                    model = "qwen2.5-coder:7b",
                    max_tokens = 4096,
                    temperature = 0,
                    timeout = 30000,
                    parse_curl_args = ollama_parse_curl_args,
                },
                ollama_local = {
                    __inherited_from = "openai",
                    api_key_name = "",
                    endpoint = "http://localhost/v1",
                    model = "qwen2.5-coder:7b",
                    max_tokens = 4096,
                    temperature = 0,
                    timeout = 30000,
                    parse_curl_args = ollama_parse_curl_args,
                },
                vllm_qwen_14 = {
                    __inherited_from = "openai",
                    api_key_name = "",
                    endpoint = "http://192.168.4.26:8000/v1",
                    model = "Qwen/Qwen2.5-Coder-14B-Instruct",
                    max_tokens = 4096,
                    temperature = 0,
                    timeout = 30000,
                },
                vllm_qwen_32 = {
                    __inherited_from = "openai",
                    api_key_name = "",
                    endpoint = "http://192.168.4.26:8000/v1",
                    model = "Qwen2.5-Coder-32B-Instruct-awq",
                    max_tokens = 4096,
                    temperature = 0,
                    timeout = 30000,
                },
                vllm_zeta = {
                    __inherited_from = "openai",
                    api_key_name = "",
                    endpoint = "http://192.168.4.26:8000/v1",
                    model = "zed-industries/zeta",
                    max_tokens = 4096,
                    temperature = 0,
                    timeout = 30000,
                }
            },
            -- ollama = {
            --     temperature = 0,
            --     max_tokens = 4096,
            -- },

            -- File selector configuration
            --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string
            file_selector = {
                provider = "fzf", -- Avoid native provider issues
                provider_opts = {},
            },
        },
        build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or
            "make",
    },
    {
        "saghen/blink.cmp",
        lazy = true,
        dependencies = { "saghen/blink.compat" },
        opts = {
            sources = {
                default = { "avante_commands", "avante_mentions", "avante_files", "minuet" },
                compat = {
                    "avante_commands",
                    "avante_mentions",
                    "avante_files",
                },
                -- LSP score_offset is typically 60
                providers = {
                    minuet = {
                        name = 'minuet',
                        module = 'minuet.blink',
                        score_offset = 100,
                    },
                    avante_commands = {
                        name = "avante_commands",
                        module = "blink.compat.source",
                        score_offset = 90,
                        opts = {},
                    },
                    avante_files = {
                        name = "avante_files",
                        module = "blink.compat.source",
                        score_offset = 100,
                        opts = {},
                    },
                    avante_mentions = {
                        name = "avante_mentions",
                        module = "blink.compat.source",
                        score_offset = 1000,
                        opts = {},
                    },
                },
            },
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        optional = true,
        ft = function(_, ft)
            vim.list_extend(ft, { "Avante" })
        end,
        opts = function(_, opts)
            opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
        end,
    },
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            spec = {
                { "<leader>a", group = "ai" },
            },
        },
    },
}
