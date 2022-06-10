{ config, pkgs, libs, ... }:
{
  imports = [ ./common.nix ];
  home.packages = with pkgs; [
    _1password-gui
    brave
    discord
    gcc
    firefox
    flameshot
    nixgl.auto.nixGLNvidia
    rofi
    notion-app-enhanced
    nix-top
    nix-output-monitor
    rofi
    notion-app-enhanced
    synergy
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/rofi";
}
