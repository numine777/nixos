return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
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
