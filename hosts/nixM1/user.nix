{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/shell/common.nix
    ../../modules/editors/neovim.nix
    ../../modules/editors/vim.nix
    ../../modules/editors/helix.nix
    ../../modules/dev/clojure.nix
    ../../modules/dev/lua.nix
    ../../modules/dev/node.nix
    ../../modules/dev/rust.nix
    ../../modules/dev/nix.nix
    ../../modules/dev/python.nix
    ../../modules/programs/mac-default.nix
    ../../modules/desktop/windowManagers/yabai.nix
  ];

  config.modules = {
    desktop = {
      windowManager = {
        yabai.enable = true;
      };
    };
    dev = {
      clojure.enable = true;
      lua.enable = true;
      nix.enable = true;
      node.enable = true;
      python.enable = true;
      rust.enable = true;
    };
    editors = {
      neovim.enable = true;
      vim.enable = false;
      helix.enable = true;
    };
    programs = {
      bottom.enable = true;
      kitty.enable = true;
      graphics = {
        aseprite.enable = false;
        gimp.enable = false;
        inkscape.enable = false;
        krita.enable = false;
      };
    };
  };
}
