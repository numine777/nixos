local init = function()
    vim.g.numine_colorscheme = "gruvbuddy"
    require("numine.colors").ColorMyPencils()
end

if not vim.g.vscode then
    init()
end
