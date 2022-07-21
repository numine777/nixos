{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.programs.kitty;
in
{
  options.modules.programs.kitty = {
    enable = mkEnableOption "kitty";
  };

  imports = [ ./colors/tokyonight.nix ];


  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 14;
      };
      settings = {
        cursor_shape = "block";
        window_padding_width = "10 10 10 10";
        scrollback_lines = 5000;
        tab_bar_style = "fade";
        tab_fade = 1;
        tab_bar_margin_width = 5;
        # tab_bar_margin_height = 5;
        allow_remote_control = "yes";
        hide_window_decorations = "titlebar-only";
        listen_on = "unix:/tmp/mykitty";
      };
    };
  };
}
