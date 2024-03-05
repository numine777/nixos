return {
  { "folke/flash.nvim", enabled = false },
  -- { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  "theprimeagen/harpoon",
  "tpope/vim-fugitive",
  "theprimeagen/refactoring.nvim",
  "mbbill/undotree",
  "lewis6991/gitsigns.nvim",
  "github/copilot.vim",
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
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end,
  },
}
