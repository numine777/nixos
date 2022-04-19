{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.programs.graphics;
in
{
  options.modules.programs.graphics = {
    gimp.enable = mkEnableOption "gimp";
  };

  config = {
    home.packages = [
      (mkIf cfg.gimp.enable pkgs.gimp)
    ];
  };
}
