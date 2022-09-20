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
    nixpkgs-git-lfs.url = "github:nixos/nixpkgs/83667ff60a88e22b76ef4b0bdf5334670b39c2b6";
  };
  outputs = { self, nixpkgs, home-manager, neovim-nightly, nixpkgs-f2k, flake-utils, darwin, nixgl, nixpkgs-git-lfs, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          # system = "x86_64-linux";

          pkgs = import nixpkgs {
            inherit system;
            config = { allowUnfree = true; }; # Forgive me Mr. Stallman
          };
          pkgs-git-lfs = import nixpkgs-git-lfs { inherit system; };

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
            (import ./overlays/customVim.nix)
            (_: _: { git-lfs-2_13 = pkgs-git-lfs.git-lfs; })
          ];
        in
        {
          homemanagerConfigurations = {
            nixosThelio = home-manager.lib.homeManagerConfiguration {
              inherit extraSpecialArgs;
              inherit pkgs;
              modules = [
                ./hosts/nixWork/user.nix
                {
                  nixpkgs.overlays = overlays;
                }
              ];
            };
            nixos = home-manager.lib.homeManagerConfiguration
              {
                inherit extraSpecialArgs;
                inherit pkgs;
                modules = [
                  ./hosts/nixos/user.nix
                  {
                    nixpkgs.overlays = [ inputs.nixpkgs-f2k.overlays.default inputs.neovim-nightly.overlay ];
                  }
                ];
              };
            nixM1 = home-manager.lib.homeManagerConfiguration {
              inherit extraSpecialArgs;
              inherit pkgs;
              modules = [
                ./hosts/nixM1/user.nix
                {
                  nixpkgs.overlays = overlays;
                }
              ];
            };
          };
          nixosConfigurations = {
            x86_64-linux.nixos = nixpkgs.lib.nixosSystem {
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
              system = "aarch64-darwin";
              modules = [
                {
                  nixpkgs.overlays = [ inputs.nixpkgs-f2k.overlays.default inputs.neovim-nightly.overlay ];
                }
                ./hosts/nixM1/configuration.nix
              ];
            };
          };
        });
}
