{ config, pkgs, libs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ./common.nix
  ];
  home.packages = with pkgs; [
    acpi
    alsa-utils
    brightnessctl
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
  ];
}
