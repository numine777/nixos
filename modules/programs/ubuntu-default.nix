{ config, pkgs, libs, ... }:
{
  imports = [ ./linux-default.nix ];
  home.packages = with pkgs; [
    git-lfs-2_13
    openssl
  ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/rofi";
}
