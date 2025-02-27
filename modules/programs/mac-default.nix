{ config, pkgs, libs, ... }:
{
  imports = [ ./common.nix ];
  home.packages = with pkgs; [ jdk17 pscale mosh imagemagick kubectl direnv ];
}
