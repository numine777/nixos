return {
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
}
