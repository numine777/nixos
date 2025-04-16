{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/shell/linux-default.nix
    ../../modules/editors/emacs.nix
    ../../modules/editors/neovim.nix
    ../../modules/dev/lua.nix
    ../../modules/dev/node.nix
    ../../modules/dev/rust.nix
    ../../modules/dev/nix.nix
    ../../modules/dev/python.nix
  ];

  config = {
    programs.home-manager.enable = true;
    home.homeDirectory = "/home/mwalls";
    home.username = "mwalls";
    home.stateVersion = "23.11";
    home.keyboard = null;
    home.sessionVariables = {
      LOCALE_ARCHIVE_2_21 = /usr/lib/locale/locale-archive;
    };
    programs.bash = {
        enable = false;
        bashrcExtra = ''
            eval "$(direnv hook bash)"
        '';
    };
    targets.genericLinux.enable = true;
    modules = {
      dev = {
        lua.enable = false;
        nix.enable = false;
        node.enable = true;
        python.enable = false;
        rust.enable = true;
      };
      editors = {
        emacs.enable = true;
        neovim.enable = true;
      };
    };
  };
}
