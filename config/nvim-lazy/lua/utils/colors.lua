M = {}
function M.ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
  vim.schedule(function()
    require("lualine").refresh()
  end)

  local hl = function(thing, opts)
    vim.api.nvim_set_hl(0, thing, opts)
  end

  -- local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
  -- local cursorline_hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
  -- local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
  -- local win_hls = { "Normal", "NormalFloat", "FloatBorder", "FloatTitle", "FloatFooter", "SignColumn", "SignColumnSB" }
  -- for _, group in ipairs(win_hls) do
  --   hl(group, { bg = "none" })
  -- end
  -- hl("CmpItemKindCopilot", { fg = "#6CC644" })
  -- hl("CmpItemKindTabnine", { fg = "#CA42F0" })
  -- hl("CmpItemKindCrate", { fg = "#F64D00" })
  -- hl("CmpItemKindEmoji", { fg = "#FDE030" })
  -- hl("SLCopilot", { fg = "#6CC644", bg = statusline_hl.background })
  -- hl("SLGitIcon", { fg = "#E8AB53", bg = cursorline_hl.background })
  -- hl("SLBranchName", { fg = normal_hl.foreground, bg = cursorline_hl.background })
  -- hl("SLSeparator", { fg = cursorline_hl.background, bg = statusline_hl.background })

  hl("ColorColumn", {
    ctermbg = 0,
    bg = "None",
  })

  hl("CursorLineNR", {
    bg = "None",
  })

  hl("Normal", {
    bg = "none",
  })

  -- hl("NormalFloat", {
  --   bg = "none",
  -- })

  hl("LineNr", {
    fg = "#5eacd3",
  })

  -- hl("netrwDir", {
  --   fg = "#5eacd3",
  -- })
  --
  hl("WinSeparator", { background = nil })
  -- require("notify").setup({
  --   background_colour = "#000000",
  -- })
end

return M
