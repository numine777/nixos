{ config, pkgs, libs, ... }:
{
  imports = [
    ./common.nix
  ];
  home.packages = with pkgs; [
    direnv
    cascadia-code
    ibm-plex
    (nerdfonts.override { fonts = [ "CascadiaCode" "FiraCode" "Iosevka" "JetBrainsMono" ]; })
    noto-fonts-emoji-blob-bin
  ];
}
