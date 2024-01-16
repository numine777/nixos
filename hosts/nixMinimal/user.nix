{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/shell/linux-default.nix
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
        enable = true;
        bashrcExtra = ''
            eval "$(direnv hook bash)"
        '';
    };
    targets.genericLinux.enable = true;
    modules = {
      dev = {
        lua.enable = true;
        nix.enable = true;
        node.enable = true;
        python.enable = true;
        rust.enable = true;
      };
      editors = {
        neovim.enable = true;
      };
    };
  };
}
