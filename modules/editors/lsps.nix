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
      nodePackages.yaml-language-server
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
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
