function ColorMyPencils(color)
    vim.opt.background = "dark"
    color = color or "oxocarbon"
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

    -- hl("netrwDir", {
    --     fg = "#5eacd3",
    -- })

    hl("WinSeparator", { background = nil })
end

return {
	"nyoom-engineering/oxocarbon.nvim",
    config = function()
        ColorMyPencils()
    end,
}
