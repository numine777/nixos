{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.dev.golang;
in
{
  options.modules.dev.golang = {
    enable = mkEnableOption "golang";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.go_1_18 ];
  };
}
