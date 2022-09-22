local nnoremap = require("numine.mapper").nnoremap

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

nnoremap("<c-q>", ":call QuickFixToggle()<CR>", { silent = true})
