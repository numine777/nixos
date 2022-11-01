local init = function()
    require("lualine").setup({})
end

if not vim.g.vscode then
    init()
end
