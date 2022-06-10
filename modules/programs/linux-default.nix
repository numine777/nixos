{ config, pkgs, libs, ... }:
{
  imports = [ ./common.nix ];
  home.packages = with pkgs; [
    _1password-gui
    brave
    discord
    firefox
    flameshot
    gcc
    firefox
    flameshot
    rofi
    notion-app-enhanced
    nix-top
    nix-output-monitor
    rofi
    notion-app-enhanced
    rofi
    synergy
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/rofi";
}
