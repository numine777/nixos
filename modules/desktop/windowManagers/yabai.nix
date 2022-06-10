{ inputs, config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.desktop.windowManager.yabai;
in
{
  options.modules.desktop.windowManager.yabai = {
    enable = mkEnableOption "yabai";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.skhd ];
    home.file = {
      ".yabairc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/.yabairc";
      ".config/skhd".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/skhd";
    };
  };
}
