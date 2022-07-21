{ config, pkgs, lib, ... }:
{
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
    ../../modules/programs/ubuntu-default.nix
    ../../modules/desktop
    ../../modules/desktop/windowManagers/awesome.nix
    ../../modules/desktop/windowManagers/berry.nix
    ../../modules/desktop/windowManagers/herbstluftwm.nix
    ../../modules/desktop/windowManagers/i3.nix
    ../../modules/desktop/windowManagers/sway.nix
  ];

  config = {
    programs.home-manager.enable = true;
    home.homeDirectory = "/home/mwalls";
    home.username = "mwalls";
    home.stateVersion = "22.11";
    home.packages =
      let
        nixGLNvidiaScript = pkgs.writeShellScriptBin "nixGLNvidia" ''
          $(NIX_PATH=nixpkgs=${inputs.nixpkgs} nix-build ${inputs.nixgl} -A auto.nixGLNvidia --no-out-link)/bin/* "$@"
        '';
        nixGLIntelScript = pkgs.writeShellScriptBin "nixGLIntel" ''
          $(NIX_PATH=nixpkgs=${inputs.nixpkgs} nix-build ${inputs.nixgl} -A nixGLIntel --no-out-link)/bin/* "$@"
        '';
        nixVulkanIntelScript =
          pkgs.writeShellScriptBin "nixVulkanIntel" ''
            $(NIX_PATH=nixpkgs=${inputs.nixpkgs} nix-build ${inputs.nixgl} -A nixVulkanIntel --no-out-link)/bin/* "$@"
          '';
        nixVulkanNvidiaScript =
          pkgs.writeShellScriptBin "nixVulkanNvidia" ''
            $(NIX_PATH=nixpkgs=${inputs.nixpkgs} nix-build ${inputs.nixgl} -A auto.nixVulkanNvidia --no-out-link)/bin/* "$@"
          '';
      in
      with pkgs; [
        nixGLNvidiaScript
        nixGLIntelScript
        nixVulkanIntelScript
        nixVulkanNvidiaScript
      ];
    home.keyboard = null;
    home.sessionVariables = {
      LOCALE_ARCHIVE_2_21 = /usr/lib/locale/locale-archive;
      NIXPKGS_ALLOW_UNFREE = true;
    };
    modules = {
      desktop = {
        picom.enable = true;
        dunst.enable = true;
        windowManager = {
          awesome.enable = false;
          berry.enable = false;
          herbstluftwm.enable = false;
          i3.enable = true;
          sway.enable = false;
        };
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
        emacs.enable = false;
        neovim.enable = true;
        vim.enable = false;
        helix.enable = true;
      };
      programs = {
        bottom.enable = true;
        irssi.enable = false;
        kitty.enable = true;
        alacritty.enable = true;
        graphics = {
          aseprite.enable = false;
          gimp.enable = true;
          inkscape.enable = true;
          krita.enable = false;
        };
      };
    };
  };
}
