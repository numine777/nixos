{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.dev.node;
in
{
  options.modules.dev.node = {
    enable = mkEnableOption "node";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ nodejs pnpm bun eas-cli ];
    home.sessionVariables = {
      NPM_CONFIG_USERCONFIG = "$HOME/.config/npm/config";
      NPM_CONFIG_CACHE = "$HOME/.cache/npm";
      NPM_CONFIG_TMP = "/tmp/npm";
      NPM_CONFIG_PREFIX = "$HOME/.cache/npm";
      NODE_REPL_HISTORY = "$HOME/.cache/node/repl_history";
    };
  };
}
