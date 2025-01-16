{ config, pkgs, ... }:
let
  nixGLWrap = import ../../utils/nixGLWrap.nix { inherit pkgs; };
  my_slack = nixGLWrap pkgs.slack;
  my_flameshot = nixGLWrap pkgs.flameshot;
in
{
  imports = [ ./common.nix ];
  home.packages = with pkgs; [
    arandr
    brave
    firefox
    gcc
    my_flameshot
    rofi
    mosh
    nix-top
    nix-output-monitor
    my_slack
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/rofi";
}
