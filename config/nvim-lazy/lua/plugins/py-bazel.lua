return {
  "numine777/py-bazel.nvim",
  config = function()
    require("py-bazel").setup({
      library_path_marker = "python",
      pip_deps_marker = "npip",
      -- global_pyright_config = "~/.config/lvim/lsp-settings/pyright.json",
    })
  end,
}
