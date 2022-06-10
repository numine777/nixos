{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.editors.helix;
in
{
  options.modules.editors.helix = {
    enable = mkEnableOption "helix";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      helix
    ];
    home.file.".config/helix".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/helix";
  };
}
