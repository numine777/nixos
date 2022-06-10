lvim.plugins = {
  {
    { "akinsho/flutter-tools.nvim", commit = "d9697b913a7e199e48b09403755774bed7063a90" },
    "ThePrimeagen/git-worktree.nvim",
    "tpope/vim-fugitive",
    "ThePrimeagen/harpoon",
    "mtth/scratch.vim",
    "Shatur/neovim-ayu",
    "romgrk/nvim-treesitter-context",
    { "npxbr/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } },
    "shaunsingh/nord.nvim",
    { "norcalli/nvim-colorizer.lua" },
    "folke/tokyonight.nvim",
    { "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" },
    -- { "github/copilot.vim" },
    {
      "akinsho/git-conflict.nvim",
      config = function()
        require("git-conflict").setup()
      end,
    },
    {
      "ggandor/lightspeed.nvim",
      event = "BufRead",
    },
    {
      "kevinhwang91/nvim-bqf",
      event = { "BufRead", "BufNew" },
      config = function()
        require("bqf").setup({
          auto_enable = true,
          preview = {
            win_height = 12,
            win_vheight = 12,
            delay_syntax = 80,
            border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
          },
          func_map = {
            vsplit = "",
            ptogglemode = "z,",
            stoggleup = "",
          },
          filter = {
            fzf = {
              action_for = { ["ctrl-s"] = "split" },
              extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
            },
          },
        })
      end,
    },
  },
}

-- Harpoon settings
require("harpoon").setup({
  nav_first_in_list = true,
})

vim.g.scratch_persistence_file = CACHE_PATH .. "/.vim/scratch_file"
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("flutter")
require 'colorizer'.setup()
