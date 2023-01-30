local init = function()
    local parser_install_dir = vim.fn.stdpath("data") .. "/site"
    require("nvim-treesitter.configs").setup({
        ensure_installed = {},
        sync_install = false,

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        parser_install_dir = parser_install_dir,
    })
end

if not vim.g.vscode then
    init()
end
