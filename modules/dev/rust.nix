{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.dev.rust;
in
{
  options.modules.dev.rust = {
    enable = mkEnableOption "rust";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.rustup pkgs.cargo-nextest ];
    home.sessionVariables = {
      RUSTUP_HOME = "${config.home.homeDirectory}/.local/share/rustup";
      CARGO_HOME = "${config.home.homeDirectory}/.local/share/cargo";
    };
    home.sessionPath = [ "$CARGO_HOME/bin" ];
  };
}
