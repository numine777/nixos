{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/shell/mac-default.nix
    ../../modules/editors/neovim.nix
    ../../modules/editors/vim.nix
    ../../modules/editors/emacs.nix
    ../../modules/editors/helix.nix
    ../../modules/editors/lsps.nix
    ../../modules/dev/clojure.nix
    ../../modules/dev/go.nix
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
        clojure.enable = false;
        lua.enable = true;
        nix.enable = false;
        node.enable = true;
        python.enable = false;
        rust.enable = true;
        ocaml.enable = false;
        golang.enable = true;
      };
      editors = {
        neovim.enable = true;
        vim.enable = false;
        emacs.enable = false;
        helix.enable = true;
        lsp.enable = true;
      };
      programs = {
        bottom.enable = true;
        kitty.enable = false;
        alacritty.enable = false;
        ghostty.enable = false;
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
