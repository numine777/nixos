return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()
        vim.keymap.set("n", "<leader>gn", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", silent)
        vim.keymap.set("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", silent)
        vim.keymap.set("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", silent)
        vim.keymap.set("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", silent)
        vim.keymap.set("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", silent)
        vim.keymap.set("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", silent)
        vim.keymap.set("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", silent)
        vim.keymap.set("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", silent)
    end,
}