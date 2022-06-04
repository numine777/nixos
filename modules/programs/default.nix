{ config, pkgs, libs, ... }:
{
  imports = [ ./bottom.nix ./graphics.nix ./irssi.nix ./kitty ./mail.nix ];
  home.packages = with pkgs; [
    _1password-gui
    alacritty
    brave
    discord
    firefox
    flameshot
    obsidian
    postman
    rofi
    notion-app-enhanced
    slack-dark
    synergy
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/rofi";
}
