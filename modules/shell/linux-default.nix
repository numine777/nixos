{ config, pkgs, libs, ... }:
{
  imports = [
    ./common.nix
  ];
  home.packages = with pkgs; [
    acpi
    alsa-utils
    brightnessctl
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
    zoxide
  ];
}
