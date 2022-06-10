{ config, pkgs, libs, ... }:
{
  imports = [ ./bottom.nix ./graphics.nix ./irssi.nix ./kitty ./mail.nix ];
  home.packages = with pkgs; [
    alacritty
    k9s
    lazygit
    lazydocker
    nnn
    obsidian
    postman
    slack-dark
  ];
}
