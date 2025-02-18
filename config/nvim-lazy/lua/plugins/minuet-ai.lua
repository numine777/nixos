return {
    'milanglacier/minuet-ai.nvim',
    config = function()
        require('minuet').setup {
            provider = 'openai_fim_compatible',
            n_completions = 1,
            context_window = 4096,
            provider_options = {
                openai_fim_compatible = {
                    api_key = 'TERM',
                    name = 'vllm',
                    endpoint = 'http://192.168.4.26:8000/v1/chat/completions',
                    model = 'zed-industries/zeta',
                    optional = {
                        max_tokens = 256,
                        top_p = 0.9,
                    },
                },
            },
        }
    end,
}
