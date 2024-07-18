M = {}

function M.setup()
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

    local builtin = require("telescope.builtin")
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

    local function set_background(content)
        vim.fn.system("feh --bg-scale " .. content)
    end

    local function select_background(prompt_bufnr, map)
        local function set_the_background(close)
            local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
            local path = content.cwd .. "/" .. content.value
            print(path)
            set_background(path)
            if close then
                require("telescope.actions").close(prompt_bufnr)
            end
        end

        map("i", "<C-p>", function()
            set_the_background()
        end)

        map("i", "<CR>", function()
            set_the_background(true)
        end)
    end

    local function image_selector(prompt, cwd)
        return function()
            require("telescope.builtin").find_files({
                prompt_title = prompt,
                cwd = cwd,

                attach_mappings = function(prompt_bufnr, map)
                    select_background(prompt_bufnr, map)

                    -- Please continue mapping (attaching additional key maps):
                    -- Ctrl+n/p to move up and down the list.
                    return true
                end,
            })
        end
    end

    vim.keymap.set("n", "<leader>sd", search_dotfiles, {})
    vim.keymap.set("n", "<leader>sw", image_selector("< Anime Bobs > ", "~/personal/anime"), {})
    vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
    vim.keymap.set("n", "<C-p>", find_project_files, {})
    vim.keymap.set("n", "<leader>st", function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, {})
    vim.keymap.set("n", "<leader>sy", function()
        require("telescope.builtin").live_grep({ type_filter = vim.fn.input("File Type > ") })
    end)
end

return M
