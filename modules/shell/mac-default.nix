{ config, pkgs, libs, ... }:
{
  imports = [
    ./common.nix
    ./git.nix
  ];
  home.packages = with pkgs; [
    direnv
    cascadia-code
    ibm-plex
    # (nerd-fonts.override { fonts = [ "CascadiaCode" "FiraCode" "Iosevka" "JetBrainsMono" ]; })
    noto-fonts-emoji-blob-bin
  ];
}
