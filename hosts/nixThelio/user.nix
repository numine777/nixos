{ config, pkgs, lib, ... }: {
  imports = [
    ../../modules/shell/linux-default.nix
    ../../modules/editors/neovim.nix
    ../../modules/editors/helix.nix
    ../../modules/editors/emacs.nix
    ../../modules/editors/vim.nix
    ../../modules/dev/clojure.nix
    ../../modules/dev/lua.nix
    ../../modules/dev/node.nix
    ../../modules/dev/rust.nix
    ../../modules/dev/go.nix
    ../../modules/dev/nix.nix
    ../../modules/dev/python.nix
    ../../modules/programs/linux-gui.nix
    ../../modules/desktop
    ../../modules/desktop/gtk.nix
  ];

  config = {
    programs.home-manager.enable = true;
    home.homeDirectory = "/home/scott";
    home.username = "scott";
    home.stateVersion = "23.11";
    home.keyboard = null;
    targets.genericLinux.enable = true;
    modules = {
      desktop = {
        picom.enable = true;
        dunst.enable = true;
      };
      dev = {
        clojure.enable = true;
        lua.enable = true;
        nix.enable = true;
        node.enable = true;
        python.enable = true;
        rust.enable = true;
        golang.enable = true;
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
        wezterm.enable = false;
        alacritty.enable = false;
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
