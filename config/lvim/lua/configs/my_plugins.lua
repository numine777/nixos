lvim.plugins = {
  {
    { "akinsho/flutter-tools.nvim", commit = "d9697b913a7e199e48b09403755774bed7063a90" },
    "ThePrimeagen/git-worktree.nvim",
    "tpope/vim-fugitive",
    "mbbill/undotree",
    "ThePrimeagen/harpoon",
    {
      "Shatur/neovim-cmake",
      config = function()
        require("cmake").setup({})
      end,
    },
    "mtth/scratch.vim",
    "Shatur/neovim-ayu",
    "romgrk/nvim-treesitter-context",
    {
      "npxbr/gruvbox.nvim",
      requires = { "rktjmp/lush.nvim" },
      config = function()
        require("gruvbox").setup({
          contrast = "hard", -- can be "hard", "soft" or empty string
          transparent_mode = true,
        })
      end,
    },
    { "shaunsingh/oxocarbon.nvim", branch = "fennel" },
    "shaunsingh/nord.nvim",
    { "norcalli/nvim-colorizer.lua" },
    -- "folke/tokyonight.nvim",
    { 'shaunsingh/oxocarbon.nvim', branch = 'fennel' },
    {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        require("catppuccin").setup()
      end,
    },
    { "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" },
    {
      "xbase-lab/xbase",
      run = "make install", -- make free_space (not recommended, longer build time)
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "neovim/nvim-lspconfig",
      },
      config = function()
        require("xbase").setup({}) -- see default configuration bellow
      end,
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
    {
      "akinsho/git-conflict.nvim",
      tag = "*",
      config = function()
        require("git-conflict").setup()
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
require("colorizer").setup()
