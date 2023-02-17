local init = function()
    local nnoremap = require("numine.mapper").nnoremap
    local tnoremap = require("numine.mapper").tnoremap

    local silent = { silent = true }

    -- Terminal commands
    -- ueoa is first through fourth finger left hand home row.
    -- This just means I can crush, with opposite hand, the 4 terminal positions
    --
    -- These functions are stored in harpoon.  A plugn that I am developing
    nnoremap("<leader>a", function()
        require("harpoon.mark").add_file()
    end, silent)
    nnoremap("<C-e>", function()
        require("harpoon.ui").toggle_quick_menu()
    end, silent)

    nnoremap("<C-h>", function()
        require("harpoon.ui").nav_file(1)
    end, silent)
    nnoremap("<C-t>", function()
        require("harpoon.ui").nav_file(2)
    end, silent)
    nnoremap("<C-n>", function()
        require("harpoon.ui").nav_file(3)
    end, silent)
    nnoremap("<C-s>", function()
        require("harpoon.ui").nav_file(4)
    end, silent)
    nnoremap("<leader>ta", function()
        require("harpoon.term").gotoTerminal(1)
    end, silent)
    nnoremap("<leader>to", function()
        require("harpoon.term").gotoTerminal(2)
    end, silent)
    nnoremap("<leader>te", function()
        require("harpoon.tmux").gotoTerminal(2)
    end, silent)
    nnoremap("<leader>tu", function()
        require("harpoon.tmux").gotoTerminal(3)
    end, silent)
    nnoremap("<leader>tt", function()
        vim.cmd("wincmd s")
        require("harpoon.term").gotoTerminal(1)
    end, silent)
    tnoremap("<C-j>", function()
        vim.cmd("wincmd q")
    end, silent)
end

if not vim.g.vscode then
    init()
end
