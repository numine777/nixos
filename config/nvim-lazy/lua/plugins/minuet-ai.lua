return {
    'milanglacier/minuet-ai.nvim',
    config = function()
        require('minuet').setup {
            provider = 'openai_fim_compatible',
            n_completions = 1,
            context_window = 512,
            provider_options = {
                openai_fim_compatible = {
                    api_key = 'TERM',
                    name = 'Vllm',
                    end_point = 'http://192.168.4.26/v1/completions',
                    -- model = 'zed-industries/zeta',
                    model = 'Qwen/Qwen2.5-Coder-14B-Instruct',
                    optional = {
                        max_tokens = 256,
                        top_p = 0.9,
                    },
                    template = {
                        prompt = function(context_before_cursor, context_after_cursor)
                            return '<|fim_prefix|>'
                                .. context_before_cursor
                                .. '<|fim_suffix|>'
                                .. context_after_cursor
                                .. '<|fim_middle|>'
                        end,
                        suffix = false,
                    },
                },
            },
            -- notify = "debug",
        }
    end,
}
