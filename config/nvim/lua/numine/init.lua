local M = {}

M.init = function()
  require("numine.sets")
  -- require("plugins")
  require("numine.highlights").init()
  require("numine.autocmds")
  require("numine.mapper")
  require("numine.telescope")
end

return M
