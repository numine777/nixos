{ config, pkgs, libs, ... }:
let
  nixGLWrap = import ../../utils/nixGLWrap.nix { inherit pkgs; };
  my_slack = nixGLWrap pkgs.slack;
  my_flameshot = nixGLWrap pkgs.flameshot;
in
{
  imports = [ ./common.nix ];
  home.packages = with pkgs; [
    # _1password-gui
    arandr
    brave
    # discord
    firefox
    gcc
    my_flameshot
    jdk8
    rofi
    mosh
    nix-top
    nix-output-monitor
    my_slack
    # notion-app-enhanced
    # synergy
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/rofi";
}
