{ config, pkgs, libs, ... }:
{
  imports = [ ./common.nix ];
  home.packages = with pkgs; [
    _1password-gui
    arandr
    brave
    discord
    firefox
    gcc
    flameshot
    jdk8
    rofi
    mosh
    nix-top
    nix-output-monitor
    notion-app-enhanced
    synergy
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/rofi";
}
