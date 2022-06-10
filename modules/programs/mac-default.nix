{ config, pkgs, libs, ... }:
{
  imports = [ ./common.nix ];
  home.packages = with pkgs; [ _1password notion-app-enhanced-v2.0.18 mosh ];
}
