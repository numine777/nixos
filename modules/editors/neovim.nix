{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.editors.neovim;
in
{
  options.modules.editors.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      stylua
      shellcheck
      black
      python39Packages.isort
      rnix-lsp
    ];
    programs.neovim =
      {
        enable = true;
        package = pkgs.neovim-nightly;
        plugins = with pkgs; [
          # languages
          vimPlugins.nvim-lspconfig
          vimPlugins.vim-nix

          # treesitter
          customVim.nvim-treesitter

          # completion
          customVim.cmp-tabnine
          vimPlugins.cmp-buffer
          vimPlugins.cmp-cmdline
          vimPlugins.cmp-nvim-lsp
          vimPlugins.cmp-path
          vimPlugins.cmp-treesitter
          vimPlugins.cmp-vsnip
          vimPlugins.lspkind-nvim
          vimPlugins.nvim-cmp
          vimPlugins.vim-vsnip

          # telescope
          vimPlugins.plenary-nvim
          vimPlugins.popup-nvim
          vimPlugins.telescope-nvim

          # theme
          vimPlugins.gruvbox-community

          # extras
          vimPlugins.gitsigns-nvim
          vimPlugins.lsp-colors-nvim
          customVim.lir-nvim
          vimPlugins.lualine-nvim
          vimPlugins.nerdcommenter
          vimPlugins.nvim-treesitter-context
          vimPlugins.nvim-web-devicons
          vimPlugins.nvim-bqf
          vimPlugins.fugitive
          vimPlugins.undotree
          customVim.harpoon
          customVim.refactoring-nvim
          vimPlugins.symbols-outline-nvim
          vimPlugins.luasnip
          vimPlugins.null-ls-nvim
          # customVim.git-worktree-nvim

        ];
        extraConfig = "lua require(\"numine\").init()";
      };
    home.file.".config/nvim/after".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/nvim/after";
    home.file.".config/nvim/lua".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/nvim/lua";
    home.file.".config/lvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/lvim";
  };
}
