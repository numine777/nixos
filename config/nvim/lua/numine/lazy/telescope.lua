return {

		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = require("telescope.actions").cycle_history_next,
                            ["<C-k>"] = require("telescope.actions").cycle_history_prev,
                        },
                    },
                },
                pickers = {
                    git_files = {
                        hidden = true,
                        show_untracked = true,
                    },
                },
            })

            local builtin = require('telescope.builtin')
            -- local telescope = require('telescope')

            -- telescope.load_extension('terms')
            local function find_project_files(opts)
                opts = opts or {}
                local ok = pcall(builtin.git_files, opts)
                if not ok then
                    builtin.find_files(opts)
                end
            end

            local function search_dotfiles()
                require("telescope.builtin").find_files({
                    prompt_title = "< VimRC >",
                    cwd = vim.env.NVIM_DOTFILES,
                    hidden = true,
                })
            end

            vim.keymap.set('n', '<leader>sd', search_dotfiles, {})
            vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', find_project_files, {})
            vim.keymap.set('n', '<leader>st', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>sy', function()
                require('telescope.builtin').live_grep({ type_filter = vim.fn.input('File Type > ') })
            end)
		end,
}