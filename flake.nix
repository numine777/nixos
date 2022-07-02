{
  description = "My NixOS/Nix-Darwin Configurations";
  inputs = {
    nixpkgs.url = "nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nixgl.url = "github:guibou/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

  };
  outputs = { self, nixpkgs, home-manager, neovim-nightly, nixpkgs-f2k, flake-utils, darwin, nixgl, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          # system = "x86_64-linux";

          pkgs = import nixpkgs {
            inherit system;
            config = { allowUnfree = true; }; # Forgive me Mr. Stallman
          };

          lib = nixpkgs.lib.extend
            (final: prev:
              let
                inherit (lib) mkOption types;
              in
              {

                mkOpt = type: default:
                  mkOption { inherit type default; };

                mkOpt' = type: default: description:
                  mkOption { inherit type default description; };

                mkBoolOpt = default: mkOption {
                  inherit default;
                  type = types.bool;
                  example = true;
                };
              });


          extraSpecialArgs = {
            inherit inputs self;
            bling = inputs.bling;
            rubato = inputs.rubato;
          };

          overlays = [
            nixpkgs-f2k.overlays.default
            neovim-nightly.overlay
            nixgl.overlay
          ];
        in
        {
          homemanagerConfigurations = {
            nixosThelio = home-manager.lib.homeManagerConfiguration {
              inherit extraSpecialArgs;
              configuration = { pkgs, config, ... }:
                {
                  home.stateVersion = "21.11";
                  programs.home-manager.enable = true;
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
                  nixpkgs.overlays = overlays;
                  imports = [ ./hosts/nixWork/user.nix ];
                };
              system = "x86_64-linux";
              homeDirectory = "/home/mwalls";
              username = "mwalls";
              stateVersion = "21.11";
            };
            nixos = home-manager.lib.homeManagerConfiguration
              {
                inherit extraSpecialArgs;
                pkgs =
                  let
                    inherit pkgs;
                  in
                  import pkgs.path { overlays = [ inputs.nixpkgs-f2k.overlays.default inputs.neovim-nightly.overlay ]; };
                modules = [
                  ./hosts/nixos/user.nix
                ];
              };
            nixM1 = home-manager.lib.homeManagerConfiguration {
              inherit extraSpecialArgs;
              configuration = { pkgs, config, ... }:
                {
                  programs.home-manager.enable = true;
                  nixpkgs.overlays = overlays;
                  imports = [ ./hosts/nixM1/user.nix ];
                };
              system = "aarch64-darwin";
              homeDirectory = "/Users/scott";
              username = "scott";
            };
          };
          nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                {
                  nixpkgs.overlays = overlays;
                }
                ./hosts/nixos/configuration.nix
              ];
            };
          };
          darwinConfigurations = {
            Scotts-MacBook-Pro = darwin.lib.darwinSystem {
              inherit system;
              modules = [
                {
                  nixpkgs.overlays = overlays;
                }
                ./hosts/nixM1/configuration.nix
              ];
            };
          };
        });
}
