M = {}

function M.setup()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
end

return M

