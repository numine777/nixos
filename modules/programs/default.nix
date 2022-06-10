{ config, pkgs, libs, ... }:
{
  imports = [ ./bottom.nix ./graphics.nix ./irssi.nix ./kitty ];
  home.packages = with pkgs; [
    _1password-gui
    brave
    discord
    gcc
    firefox
    flameshot
    nixgl.auto.nixGLNvidia
    postman
    rofi
    notion-app-enhanced
    nix-top
    nix-output-monitor
    slack-dark
    synergy
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/rofi";
}
