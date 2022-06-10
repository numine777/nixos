{ config, pkgs, libs, ... }:
{
  imports = [ ./bottom.nix ./graphics.nix ./irssi.nix ./kitty ./mail.nix ];
  home.packages = with pkgs; [
    alacritty
    obsidian
    postman
    slack-dark
  ];
}
