{ config, pkgs, libs, ... }:
{
  imports = [ ./bottom.nix ./graphics.nix ./irssi.nix ./kitty ./mail.nix ./alacritty.nix ];
  home.packages = with pkgs; [
    k9s
    lazygit
    lazydocker
    nnn
    obsidian
    postman
    slack-dark
  ];
}
