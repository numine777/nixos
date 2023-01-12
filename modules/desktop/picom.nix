{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.modules.desktop.picom;
in
{
  options.modules.desktop.picom = {
    enable = mkEnableOption "picom";
  };

  config = mkIf cfg.enable {
    services.picom = {
      enable = true;
      package = pkgs.picom-git;
      fade = false;
      shadow = true;
      shadowExclude = [
        "name = 'Notification'"
        "class_g = 'Conky'"
        "class_g = 'Rofi'"
        "class_g ?= 'Notify-osd'"
        "class_g = 'Cairo-clock'"
        "class_g = 'awesome'"
        "_GTK_FRAME_EXTENTS@:c"
      ];
    };
  };
}
