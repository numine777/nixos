local init = function()
    local Remap = require("numine.mapper")
    local nnoremap = Remap.nnoremap
    local vnoremap = Remap.vnoremap
    require("refactoring").setup()
    -- Remaps for the refactoring operations currently offered by the plugin
    vnoremap(
        "<leader>re",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]]
    )
    vnoremap(
        "<leader>rf",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]]
    )
    vnoremap(
        "<leader>rv",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]]
    )
    vnoremap(
        "<leader>ri",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]]
    )

    -- Extract block doesn't need visual mode
    nnoremap(
        "<leader>rb",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]]
    )
    nnoremap(
        "<leader>rbf",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]]
    )

    -- Inline variable can also pick up the identifier currently under the cursor without visual mode
    nnoremap(
        "<leader>ri",
        [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]]
    )
end

if not vim.g.vscode then
    init()
end
