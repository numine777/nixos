local init = function()
    require("numine.colors").ColorMyPencils()
end

if not vim.g.vscode then
    init()
end
