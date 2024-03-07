function ColorMyPencils(color)
    vim.opt.background = "dark"
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    local hl = function(thing, opts)
        vim.api.nvim_set_hl(0, thing, opts)
    end

    local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
    local cursorline_hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
    local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
    hl("Normal", { bg = "none" })
    hl("NormalFloat", { bg = "none" })
    hl("FidgetTask", { fg = "none", bg = "none" })
    hl("FidgetTitle", { fg = "none", bg = "none" })
    hl("CmpItemKindCopilot", { fg = "#6CC644" })
    hl("CmpItemKindTabnine", { fg = "#CA42F0" })
    hl("CmpItemKindCrate", { fg = "#F64D00" })
    hl("CmpItemKindEmoji", { fg = "#FDE030" })
    hl("SLCopilot", { fg = "#6CC644", bg = statusline_hl.background })
    hl("SLGitIcon", { fg = "#E8AB53", bg = cursorline_hl.background })
    hl("SLBranchName", { fg = normal_hl.foreground, bg = cursorline_hl.background })
    hl("SLSeparator", { fg = cursorline_hl.background, bg = statusline_hl.background })
    hl("Column", { bg = "none" })
    hl("LineNR", { bg = "none" })
    hl("LineNR", { bg = "none" })
    hl("FloatTitle", { bg = "none" })
    hl("FloatFooter", { bg = "none" })
    hl("NormalNC", { bg = "none" })

    hl("SignColumn", {
        bg = "none",
    })

    -- hl("ColorColumn", {
    --     ctermbg = 0,
    --     bg = "#555555",
    -- })

    hl("CursorLineNR", {
        bg = "None",
    })

    hl("Normal", {
        bg = "none",
    })

    hl("NormalFloat", {
        bg = "none",
    })

    -- hl("LineNr", {
    --     fg = "#5eacd3",
    -- })

    hl("netrwDir", {
        fg = "#5eacd3",
        bg = "none",
    })

    hl("WinSeparator", { background = nil })
end

return {
    {
        "nyoom-engineering/oxocarbon.nvim",
        config = function()
            ColorMyPencils()
        end,
    },
	{
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				disable_float_background = true,
			})
		end,
	},
    {
        "loctvl842/monokai-pro.nvim",
        config = function()
            require("monokai-pro").setup({
                transparent_background = true,
                terminal_colors = true,
                devicons = true, -- highlight the icons of `nvim-web-devicons`
                styles = {
                    comment = { italic = true },
                    keyword = { italic = false },       -- any other keyword
                    type = { italic = false },          -- (preferred) int, long, char, etc
                    storageclass = { italic = false },  -- static, register, volatile, etc
                    structure = { italic = false },     -- struct, union, enum, etc
                    parameter = { italic = false },     -- parameter pass in function
                    annotation = { italic = false },
                    tag_attribute = { italic = false }, -- attribute of tag in reactjs
                },
                filter = "classic",                     -- classic | octagon | pro | machine | ristretto | spectrum
                -- Enable this will disable filter option
                day_night = {
                    enable = false,            -- turn off by default
                    day_filter = "pro",        -- classic | octagon | pro | machine | ristretto | spectrum
                    night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
                },
                inc_search = "background",     -- underline | background
                background_clear = {
                    -- "float_win",
                    -- "toggleterm",
                    "telescope",
                    -- "which-key",
                    "renamer",
                    -- "notify",
                    "nvim-tree",
                    -- "neo-tree",
                    -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
                }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
                plugins = {
                    bufferline = {
                        underline_selected = false,
                        underline_visible = false,
                    },
                    indent_blankline = {
                        context_highlight = "default", -- default | pro
                        context_start_underline = false,
                    },
                },
                ---@param c Colorscheme
                override = function(c) end,
            })
        end,
    }
}
