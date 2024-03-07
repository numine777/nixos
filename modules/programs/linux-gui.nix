{ pkgs, ... }:
{
  imports = [ ./linux-default.nix ];
  home.packages = with pkgs; [
    _1password-gui
    brave
    discord
    firefox
    notion-app-enhanced
    slack
    # synergy
  ];
}
