local M = {}

function M.ColorMyPencils()
    vim.g.gruvbox_contrast_dark = "hard"
    vim.g.gruvbox_invert_selection = "0"
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_transparent = true
    vim.opt.background = "dark"

    local hl = function(thing, opts)
        vim.api.nvim_set_hl(0, thing, opts)
    end

    require("numine.breadcrumbs").get_winbar()
    vim.cmd("colorscheme " .. vim.g.numine_colorscheme)
    local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
    local cursorline_hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
    local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
    hl("CmpItemKindCopilot", { fg = "#6CC644" })
    hl("CmpItemKindTabnine", { fg = "#CA42F0" })
    hl("CmpItemKindCrate", { fg = "#F64D00" })
    hl("CmpItemKindEmoji", { fg = "#FDE030" })
    hl("SLCopilot", { fg = "#6CC644", bg = statusline_hl.background })
    hl("SLGitIcon", { fg = "#E8AB53", bg = cursorline_hl.background })
    hl("SLBranchName", { fg = normal_hl.foreground, bg = cursorline_hl.background })
    hl("SLSeparator", { fg = cursorline_hl.background, bg = statusline_hl.background })

    hl("SignColumn", {
        bg = "none",
    })

    hl("ColorColumn", {
        ctermbg = 0,
        bg = "#555555",
    })

    hl("CursorLineNR", {
        bg = "None",
    })

    hl("Normal", {
        bg = "none",
    })

    hl("NormalFloat", {
        bg = "none",
    })

    hl("LineNr", {
        fg = "#5eacd3",
    })

    hl("netrwDir", {
        fg = "#5eacd3",
    })

    hl("WinSeparator", { background = nil })

<<<<<<< HEAD

=======
>>>>>>> 6b462660e854fd4bc0497c9ca8264c49063fa4b2
end

return M
