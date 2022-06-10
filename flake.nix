{
  description = "My NixOS/Nix-Darwin Configurations";
  inputs = {
    nixpkgs.url = "nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly, nixpkgs-f2k, flake-utils, darwin, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
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
          nixpkgs-f2k.overlay
          neovim-nightly.overlay
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
                home.keyboard = null;
                nixpkgs.overlays = overlays;
                imports = [ ./hosts/nixosThelio/user.nix ];
              };
            system = "x86_64-linux";
            homeDirectory = "/home/scott";
            username = "scott";
            stateVersion = "21.11";
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
          nixosThelio = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              {
                nixpkgs.overlays = overlays;
              }
              ./hosts/nixosThelio/configuration.nix
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
