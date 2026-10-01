{ config, pkgs, lib, inputs, ... }:

let
  cfg = config.modules.programs.pi;
  piPkgs = inputs.nixpkgs-pi.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  sharedModels = builtins.fromJSON (builtins.readFile ../../config/pi/models.json);
  sharedSettings = builtins.fromJSON (builtins.readFile ../../config/pi/settings.json);
  settingsFile = pkgs.writeText "pi-settings.json" (builtins.toJSON cfg.settings);
in
{
  options.modules.programs.pi = {
    enable = lib.mkEnableOption "Pi coding agent and shared local-model configuration";
    package = lib.mkOption {
      type = lib.types.package;
      default = piPkgs.pi-coding-agent;
      description = "Pi package, pinned independently by the nixpkgs-pi input.";
    };
    modelOverrides = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Recursive overrides for shared models, for example a host-specific baseUrl. Never put credentials here.";
    };
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = sharedSettings;
      description = "Settings enforced at activation. Other Pi settings and additional packages remain writable and are preserved.";
    };
  };

  config = lib.mkIf cfg.enable {
    # npm is needed by Pi to install the extensions declared in settings.json.
    home.packages = [ cfg.package pkgs.nodejs ];
    home.file = {
      ".pi/agent/models.json".text = builtins.toJSON (lib.recursiveUpdate sharedModels cfg.modelOverrides);
      ".pi/agent/SYSTEM.md".source = ../../config/pi/SYSTEM.md;
      ".pi/agent/agents".source = ../../config/pi/agents;
    };

    # Pi writes settings (model selection, changelog state, etc.), so do not
    # symlink settings.json into the read-only Nix store.
    home.activation.piSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run ${pkgs.python3}/bin/python3 ${../../config/pi/sync-settings.py} \
        ${lib.escapeShellArg "${config.home.homeDirectory}/.pi/agent/settings.json"} \
        ${settingsFile}
    '';
  };
}
