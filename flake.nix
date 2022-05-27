{
  description = "My NixOS Configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nixgl.url = "github:guibou/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";

    # awesomewm modules
    bling = { url = "github:BlingCorp/bling"; flake = false; };
    rubato = { url = "github:andOrlando/rubato"; flake = false; };
  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly, emacs-overlay, nixpkgs-f2k, nixgl, ... }@inputs:

    let
      system = "x86_64-linux";
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


      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; }; # Forgive me Mr. Stallman
        # overlays = [
        #   (import ./overlays/wrapWithNixGL.nix)
        #   (import ./overlays/wrappedPackages.nix)
        # ];
      };

      extraSpecialArgs = {
        inherit inputs self;
        bling = inputs.bling;
        rubato = inputs.rubato;
      };



      overlays = [
        nixpkgs-f2k.overlay
        neovim-nightly.overlay
        emacs-overlay.overlay
        nixgl.overlay
        # (import ./overlays/wrapWithNixGL.nix { inherit pkgs; inherit nixgl; })
        # (import ./overlays/wrappedPackages.nix { inherit pkgs; })
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
              imports = [ ./hosts/nixosThelio/user.nix ];
            };
          system = "x86_64-linux";
          homeDirectory = "/home/mwalls";
          username = "mwalls";
          stateVersion = "21.11";
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
    };
}
