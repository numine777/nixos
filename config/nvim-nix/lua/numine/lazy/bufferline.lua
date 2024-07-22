M = {}

function M.setup()
    require("bufferline").setup({})
    vim.keymap.set("n", "<s-h>", "<cmd>BufferLineCyclePrev<cr>")
    vim.keymap.set("n", "<s-l>", "<cmd>BufferLineCycleNext<cr>")
    vim.keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>")
    vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>")
    vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>")
end

return M
