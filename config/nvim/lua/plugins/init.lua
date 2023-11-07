return {
  { "folke/flash.nvim", enabled = false },
  -- { "nvim-neo-tree/neo-tree.nvim", enabled = false },
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
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "gd",
        function()
          vim.lsp.buf.definition()
        end,
      }
      keys[#keys + 1] = {
        "K",
        function()
          vim.lsp.buf.hover()
        end,
      }
      keys[#keys + 1] = {
        "gl",
        function()
          vim.diagnostic.open_float()
        end,
      }
      keys[#keys + 1] = {
        "<leader>lj",
        function()
          vim.diagnostic.goto_next()
        end,
      }
      keys[#keys + 1] = {
        "<leader>lk",
        function()
          vim.diagnostic.goto_prev()
        end,
      }
      keys[#keys + 1] = {
        "<leader>la",
        function()
          vim.lsp.buf.code_action()
        end,
      }
      keys[#keys + 1] = {
        "<leader>lo",
        function()
          vim.lsp.buf.code_action({
            filter = function(code_action)
              if not code_action or not code_action.data then
                return false
              end

              local data = code_action.data.id
              return string.sub(data, #data - 1, #data) == ":0"
            end,
            apply = true,
          })
        end,
      }
      keys[#keys + 1] = {
        "gr",
        function()
          vim.lsp.buf.references()
        end,
      }
      keys[#keys + 1] = {
        "<leader>lr",
        function()
          vim.lsp.buf.rename()
        end,
      }
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "LazyFile",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(
          "BUILD.bazel",
          ".null-ls-root",
          ".neoconf.json",
          "Makefile",
          ".git"
        ),
        sources = {
          nls.builtins.formatting.yapf,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.buildifier,
        },
      }
    end,
  },
}
