{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/shell/mac-default.nix
    ../../modules/editors/neovim.nix
    ../../modules/editors/vim.nix
    ../../modules/editors/emacs.nix
    ../../modules/editors/helix.nix
    ../../modules/dev/clojure.nix
    ../../modules/dev/lua.nix
    ../../modules/dev/node.nix
    ../../modules/dev/rust.nix
    ../../modules/dev/nix.nix
    ../../modules/dev/python.nix
    ../../modules/dev/ocaml.nix
    ../../modules/programs/mac-default.nix
    ../../modules/desktop/windowManagers/yabai.nix
  ];

  config = {
    programs.home-manager.enable = true;
    home.homeDirectory = "/Users/scott";
    home.username = "scott";
    home.stateVersion = "22.11";
    modules = {
      desktop = {
        windowManager = {
          yabai.enable = false;
        };
      };
      dev = {
        clojure.enable = true;
        lua.enable = true;
        nix.enable = true;
        node.enable = false;
        python.enable = false;
        rust.enable = true;
        ocaml.enable = true;
      };
      editors = {
        neovim.enable = true;
        vim.enable = false;
        emacs.enable = true;
        helix.enable = true;
      };
      programs = {
        bottom.enable = true;
        kitty.enable = true;
        alacritty.enable = true;
        graphics = {
          aseprite.enable = false;
          gimp.enable = false;
          inkscape.enable = false;
          krita.enable = false;
        };
      };
    };
  };
}
