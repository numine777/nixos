{ config, pkgs, libs, ... }:
{
  imports = [ ./bottom.nix ./graphics.nix ./irssi.nix ./kitty ];
  home.packages = with pkgs; [
    _1password-gui
    brave
    gcc
    firefox
    flameshot
    postman
    rofi
    notion-app-enhanced
    slack-dark
    synergy
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/rofi";
}
