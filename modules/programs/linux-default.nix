{ config, pkgs, ... }:
{
  imports = [ ./common.nix ];
  home.packages = with pkgs; [
    arandr
    gcc
    gdb
    flameshot
    jdk8
    rofi
    mosh
    nix-top
    nix-output-monitor
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/rofi";
}
