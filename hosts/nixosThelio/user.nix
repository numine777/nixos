{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/shell
    ../../modules/editors/neovim.nix
    ../../modules/editors/helix.nix
    ../../modules/editors/emacs.nix
    ../../modules/editors/vim.nix
    ../../modules/dev/clojure.nix
    ../../modules/dev/lua.nix
    ../../modules/dev/node.nix
    ../../modules/dev/rust.nix
    ../../modules/dev/nix.nix
    ../../modules/dev/python.nix
    ../../modules/programs
    ../../modules/desktop
    ../../modules/desktop/windowManagers/awesome.nix
    ../../modules/desktop/windowManagers/berry.nix
    ../../modules/desktop/windowManagers/herbstluftwm.nix
    ../../modules/desktop/windowManagers/i3.nix
    ../../modules/desktop/windowManagers/sway.nix
  ];

  config.modules = {
    desktop = {
      picom.enable = true;
      dunst.enable = true;
      windowManager = {
        awesome.enable = true;
        berry.enable = true;
        herbstluftwm.enable = true;
        i3.enable = true;
        sway.enable = false;
      };
    };
    dev = {
      clojure.enable = true;
      # lisp.enable = false;
      lua.enable = true;
      nix.enable = true;
      node.enable = true;
      python.enable = true;
      rust.enable = true;
    };
    editors = {
      emacs.enable = true;
      neovim.enable = true;
      vim.enable = false;
      helix.enable = true;
    };
    programs = {
      bottom.enable = true;
      irssi.enable = false;
      kitty.enable = true;
      graphics = {
        aseprite.enable = false;
        gimp.enable = true;
        inkscape.enable = true;
        krita.enable = false;
      };
    };
  };
}
