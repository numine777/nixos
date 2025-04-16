local ollama_parse_curl_args = function(code_opts)
    local Utils = require("avante.utils")
    local Config = require("avante.config")
    local P = require("avante.providers")
    local O = require("avante.providers.ollama")

    local provider_conf, request_body = P.parse_config(O)

    if not provider_conf.model or provider_conf.model == "" then
        error("Ollama model must be specified in config")
    end
    if not provider_conf.endpoint then
        error("Ollama requires endpoint configuration")
    end

    return {
        url = Utils.url_join(provider_conf.endpoint, "/api/chat"),
        headers = {
            ["Content-Type"] = "application/json",
            ["Accept"] = "application/json",
        },
        body = vim.tbl_deep_extend("force", {
            model = provider_conf.model,
            messages = O:parse_messages(prompt_opts),
            stream = true,
            system = prompt_opts.system_prompt,
            max_prompt_tokens = body_opts.max_tokens,
        }, request_body),
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
            hints = { enabled = true },

            ---@alias AvanteProvider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
            provider = "ollama_deepcoder_14_q8",            -- Recommend using Claude
            auto_suggestions_provider = "ollama_deepcoder_1_5", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
            behaviour = {
                enable_cursor_planning_mode = true,
            },
            claude = {
                endpoint = "https://api.anthropic.com",
                model = "claude-3-5-sonnet-20241022",
                temperature = 0,
                max_tokens = 4096,
            },
            vendors = {
                ollama_llama_33 = {
                    __inherited_from = "ollama",
                    endpoint = "http://192.168.5.188:11435/",
                    model = "llama3.3:70b",
                    max_tokens = 128000,
                    temperature = 0,
                    timeout = 30000,
                    parse_curl_args = ollama_parse_curl_args,
                },
                ollama_qwq_32 = {
                    __inherited_from = "ollama",
                    endpoint = "http://192.168.5.188:11435/",
                    model = "qwq:32b",
                    max_tokens = 128000,
                    temperature = 0,
                    timeout = 30000,
                    -- parse_curl_args = ollama_parse_curl_args,
                },
                ollama_deepcoder_14_q8 = {
                    __inherited_from = "ollama",
                    endpoint = "http://192.168.5.188:11435/",
                    model = "deepcoder:14b-preview-q8_0",
                    max_tokens = 128000,
                    temperature = 0,
                    timeout = 30000,
                },
                ollama_deepcoder_1_5 = {
                    __inherited_from = "ollama",
                    endpoint = "http://192.168.5.188:11435/",
                    model = "deepcoder:1.5b-preview-fp16",
                    max_tokens = 128000,
                    temperature = 0,
                    timeout = 30000,
                },
                ollama_qwen_32 = {
                    __inherited_from = "ollama",
                    endpoint = "http://192.168.5.188:11435/",
                    model = "qwen2.5-coder:32b-instruct-q8_0",
                    max_tokens = 128000,
                    temperature = 0,
                    timeout = 30000,
                    -- parse_curl_args = ollama_parse_curl_args,
                },
                ollama_qwen_14 = {
                    __inherited_from = "ollama",
                    api_key_name = "",
                    endpoint = "http://192.168.5.188:11435/",
                    model = "qwen2.5-coder:14b",
                    max_tokens = 128000,
                    temperature = 0,
                    timeout = 30000,
                    -- parse_curl_args = ollama_parse_curl_args,
                },
                ollama_qwen_7 = {
                    __inherited_from = "ollama",
                    api_key_name = "",
                    endpoint = "http://192.168.5.188:11435/",
                    model = "qwen2.5-coder:7b",
                    max_tokens = 4096,
                    temperature = 0,
                    timeout = 30000,
                    parse_curl_args = ollama_parse_curl_args,
                },
                ollama_local = {
                    __inherited_from = "ollama",
                    api_key_name = "",
                    endpoint = "http://localhost/",
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
                },
                mac_qwen_32 = {
                    __inherited_from = "openai",
                    api_key_name = "",
                    endpoint = "http://192.168.5.167:11434/v1",
                    model = "qwen2.5-coder:32b",
                    max_tokens = 4096,
                    temperature = 0,
                    timeout = 30000,
                    parse_curl_args = ollama_parse_curl_args,
                },
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
                default = { "avante_commands", "avante_mentions", "avante_files" },
                compat = {
                    "avante_commands",
                    "avante_mentions",
                    "avante_files",
                },
                -- LSP score_offset is typically 60
                providers = {
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
