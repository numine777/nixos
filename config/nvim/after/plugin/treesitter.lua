local init = function()
    local parser_install_dir = vim.fn.stdpath("data") .. "/site"
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "bash",
            "css",
            "dockerfile",
            "go",
            "gomod",
            "graphql",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "lua",
            "make",
            "nix",
            "python",
            "rust",
            "svelte",
            "tsx",
            "typescript",
            "yaml",
        },
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
