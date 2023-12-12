{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.dev.ocaml;
in
{
  options.modules.dev.ocaml = {
    enable = mkEnableOption "ocaml";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      opam
      # nodePackages.ocaml-language-server
      # ocamlPackages.utop
      # ocamlformat
      # dune-release
    ];
  };
}
