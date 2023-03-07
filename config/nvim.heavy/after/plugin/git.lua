local init = function()
    require("gitsigns").setup()
end

if not vim.g.vscode then
    init()
end
