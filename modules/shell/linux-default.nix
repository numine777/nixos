{ config, pkgs, libs, ... }:
{
  imports = [
    ./common.nix
    ./git.nix
  ];
  home.packages = with pkgs; [
    acpi
    alsa-utils
    bash
    bash-completion
    brightnessctl
    ccls
    direnv
    efibootmgr
    feh
    fortune
    hsetroot
    lm_sensors
    maim
    ncdu
    pamixer
    pass
    playerctl
    slop
    nethogs
  ];
}
