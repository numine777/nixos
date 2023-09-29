{
  description = "My NixOS/Nix-Darwin Configurations";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";
    };
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    crane.url = "github:ipetkov/crane";
    nixpkgs-fmt.url = "github:nix-community/nixpkgs-fmt";
    nixpkgs-f2k.inputs.crane.follows = "crane";
    nixpkgs-f2k.inputs.nixpkgs-fmt.follows = "nixpkgs-fmt";
    nixgl.url = "github:guibou/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-git-lfs.url = "github:nixos/nixpkgs/83667ff60a88e22b76ef4b0bdf5334670b39c2b6";

    # awesomewm modules
    bling = { url = "github:BlingCorp/bling"; flake = false; };
    rubato = { url = "github:andOrlando/rubato"; flake = false; };
  };
  outputs = { self, nixpkgs, home-manager, neovim-nightly, nixpkgs-f2k, darwin, nixgl, nixpkgs-git-lfs, ... }@inputs:
    let
      pkgs-git-lfs = import nixpkgs-git-lfs { system = "x86_64-linux"; };
      gitLfsOverlay = (_: _: { git-lfs-2_13 = pkgs-git-lfs.git-lfs; });
      customVimOverlay = import ./overlays/customVim.nix;
      # customPkgsOverlay = import ./overlays/customPkgs.nix;

      extraSpecialArgs = {
        inherit inputs self;
        bling = inputs.bling;
        rubato = inputs.rubato;
      };

      overlays = [
        nixpkgs-f2k.overlays.default
        neovim-nightly.overlay
        customVimOverlay
        # customPkgsOverlay
      ];
    in
    {
      homemanagerConfigurations = {
        nixosThelio = home-manager.lib.homeManagerConfiguration {
          inherit extraSpecialArgs;
          pkgs = import nixpkgs { system = "x86_64-linux"; config = { allowUnfree = true; }; };
          modules = [
            ./hosts/nixWork/user.nix
            {
              nixpkgs.overlays = overlays ++ [ gitLfsOverlay nixgl.overlay ];
            }
          ];
        };
        nixos = home-manager.lib.homeManagerConfiguration
          {
            inherit extraSpecialArgs;
            pkgs = import nixpkgs { system = "x86_64-linux"; config = { allowUnfree = true; }; };
            modules = [
              ./hosts/nixos/user.nix
              {
                nixpkgs.overlays = overlays;
              }
            ];
          };
        nixM1 = home-manager.lib.homeManagerConfiguration {
          inherit extraSpecialArgs;
          pkgs = import nixpkgs { system = "aarch64-darwin"; config = { allowUnfree = true; }; };
          modules = [
            ./hosts/nixM1/user.nix
            {
              nixpkgs.overlays = overlays;
            }
          ];
        };
      };
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
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
              nixpkgs.overlays = overlays;
            }
            ./hosts/nixM1/configuration.nix
          ];
        };
      };
    };
}
