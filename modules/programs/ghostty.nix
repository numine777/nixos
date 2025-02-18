{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.programs.ghostty;
in
{
  options.modules.programs.ghostty = {
    enable = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
    };
    home.file.".config/ghostty".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/ghostty";
  };
}
