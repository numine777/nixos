local M = {}

M.init = function()
    require("numine.sets")
    require("numine.highlights").init()
    require("numine.autocmds")
    require("numine.mapper")
    require("numine.telescope")
    require("numine.comment")
end

return M
