if not vim.g.vscode then
    vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
        { silent = true, noremap = true }
    )
end
