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
      package = pkgs.picom;
      # fade = false;
      # experimentalBackends = false;
      # inactiveDim = "0.05";
      shadow = true;
      extraOptions = ''
        shadow-radius = 60
        shadow-opacity = 0.25
        shadow-offset-x = -40
        shadow-offset-y = -40
        corner-radius = 0
        rounded-corners-exclude = [
          "window_type = 'dock'",
          "window_type = 'desktop'",
          "class_g = 'awesome'"
        ];
      '';
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
