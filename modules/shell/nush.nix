{ config, pkgs, libs, ... }:
{
  home.file.".config/nushell".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/nushell";
}
