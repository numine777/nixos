return {
    {
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            require("rose-pine").setup({
                disable_background = true,
                disable_float_background = true,
                disable_italics = true,
            })
        end,
    },
    {
        "navarasu/onedark.nvim",
        config = function()
            require("onedark").setup({
                transparent = true,
                -- style = 'darker',
            })
        end,
    },
    {
        "folke/tokyonight.nvim",
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
    },
    -- Lua
    {
        "tjdevries/colorbuddy.nvim",
    },
    {
        "ellisonleao/gruvbox.nvim",
        opts = {
            transparent_mode = true,
        },
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "rose-pine",
        },
    },
}
