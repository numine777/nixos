return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
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
    local lspconfig = require("lspconfig")
    -- local cmp_lsp = require("cmp_nvim_lsp")
    -- local capabilities =
    --   vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())
    lspconfig.starpls.setup({
      cmd = { "starpls", "server" },
      filetypes = { "bzl" },
    })
    opts.inlay_hints.enabled = false
  end,
}
