local init = function()
    local nnoremap = require("numine.mapper").nnoremap

    local silent = { silent = true }

    -- Terminal commands
    -- ueoa is first through fourth finger left hand home row.
    -- This just means I can crush, with opposite hand, the 4 terminal positions
    --
    -- These functions are stored in harpoon.  A plugn that I am developing
    nnoremap("<leader>gn", ":G<cr>", silent)
    nnoremap("<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", silent)
    nnoremap("<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", silent)
    nnoremap("<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", silent)
    nnoremap("<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", silent)
    nnoremap("<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", silent)
    nnoremap("<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", silent)
    nnoremap("<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", silent)
    nnoremap("<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", silent)
end

if not vim.g.vscode then
    init()
end
