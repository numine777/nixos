{ config, pkgs, libs, ... }:
{
  imports = [ ./linux-default.nix ]
  home.packages = with pkgs; [
    nixgl.auto.nixGLNvidia
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/rofi";
}
