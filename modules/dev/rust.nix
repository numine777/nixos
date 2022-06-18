{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.dev.rust;
in
{
  options.modules.dev.rust = {
    enable = mkEnableOption "rust";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.rustup ];
    home.sessionVariables = {
      RUSTUP_HOME = "$HOME/.local/share/rustup";
      CARGO_HOME = "$HOME/.local/share/cargo";
    };
    home.sessionPath = [ "$CARGO_HOME/bin" ];
  };
}
