{ config, pkgs, lib, ... }:
{
  imports = [
    ./dunst.nix
    ./picom.nix
    ./gtk.nix
  ];
  home.packages = with pkgs; [
    i3status
    tint2
    xss-lock
  ];
  home.file.".config/tint2".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/tint2";

  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 32;
  };

  xsession = {
    enable = true;
    initExtra = "~/.fehbg\nXDG_DATA_DIRS DEFAULT=@{HOME}/.nix-profile/share:/usr/local/share:/usr/share";
  };

}
