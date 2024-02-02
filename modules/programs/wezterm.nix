{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.programs.wezterm;
in
{
  options.modules.programs.wezterm = {
    enable = mkEnableOption "wezterm";
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
    };
    home.file.".".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/.wezterm.lua";
  };
}
