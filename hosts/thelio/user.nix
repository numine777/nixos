{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/shell
    ../../modules/editors/neovim.nix
    ../../modules/programs
    ../../modules/desktop
    ../../modules/desktop/windowManagers/awesome.nix
  ];

  config.modules = {
    desktop = {
      picom.enable = true;
      dunst.enable = true;
      windowManager = {
        awesome.enable = true;
        i3.enable = true;
      };
    };
    editors = {
      neovim.enable = true;
    };
    programs = {
      bottom.enable = true;
      kitty.enable = true;
      graphics = {
        gimp.enable = true;
      };
    };
  };
}
