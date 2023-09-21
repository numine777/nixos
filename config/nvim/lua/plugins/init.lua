return {
  { "folke/flash.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  "theprimeagen/harpoon",
  "tpope/vim-fugitive",
  "theprimeagen/refactoring.nvim",
  "mbbill/undotree",
  "lewis6991/gitsigns.nvim",
  "nvim-treesitter/nvim-treesitter-context",
  {
    "numine777/py-bazel.nvim",
    config = function()
      require("py-bazel").setup({
        library_path_marker = "python",
        pip_deps_marker = "npip",
        -- global_pyright_config = "~/.config/lvim/lsp-settings/pyright.json",
      })
    end,
  },
}
