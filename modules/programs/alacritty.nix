{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.programs.alacritty;
in
{
  options.modules.programs.alacritty = {
    enable = mkEnableOption "alacritty";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
    };
    home.file.".config/alacritty".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/alacritty";
  };
}
