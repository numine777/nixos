{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.programs.cmux;
in
{
  options.modules.programs.cmux = {
    enable = mkEnableOption "cmux";
  };

  config = mkIf cfg.enable {
    programs.cmux = {
      enable = true;
    };
    home.file.".config/ghostty".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/ghostty";
  };
}
