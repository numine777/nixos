local M = {}

M.init = function()
  -- require("plugins")
    require("numine.sets")
    require("numine.highlights").init()
    require("numine.autocmds")
    require("numine.mapper")
    require("numine.telescope")
    require("numine.comment")
    require("numine.lir")
end

return M
