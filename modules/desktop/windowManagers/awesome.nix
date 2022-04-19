{ inputs, config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.desktop.windowManager.awesome;
in
{
  options.modules.desktop.windowManager.awesome = {
    enable = mkEnableOption "awesome";
  };

  config = mkIf cfg.enable {
    home.file = {
      ".config/awesome".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/awesome";
      "nixos/config/awesome/modules/bling".source = inputs.bling.outPath;
      "nixos/config/awesome/modules/rubato".source = inputs.rubato.outPath;
    };
  };
}
