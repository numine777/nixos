{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.modules.programs.ghostty;
  nixGLWrap = import ../../utils/nixGLWrap.nix { pkgs = pkgs; };
in
{
  options.modules.programs.ghostty = {
    enable = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      package = nixGLWrap pkgs.ghostty;
      enable = true;
    };
    home.file.".config/ghostty".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/ghostty";
  };
}
