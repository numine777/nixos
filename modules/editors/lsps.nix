{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.editors.lsp;
in
{
  options.modules.editors.lsp = {
    enable = mkEnableOption "lsp";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      stylua
      shellcheck
      black
      nixpkgs-fmt
      nil
      yaml-language-server
      bash-language-server
      typescript-language-server
      clang-tools
      lua-language-server
      starpls
      basedpyright
      gopls
      ruff
      vtsls
    ];
  };
}
