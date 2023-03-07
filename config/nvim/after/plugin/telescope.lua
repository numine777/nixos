if not vim.g.vscode then
    local builtin = require('telescope.builtin')
    local function find_project_files(opts)
        opts = opts or {}
        local ok = pcall(builtin.git_files, opts)
        if not ok then
            builtin.find_files(opts)
        end
    end

    vim.keymap.set('n', '<leader>lf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', find_project_files, {})
    vim.keymap.set('n', '<leader>st', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>sy', function()
        require('telescope.builtin').live_grep({ type_filter = vim.fn.input('File Type > ') })
    end)
end
