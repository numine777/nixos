{ config, pkgs, libs, ... }:
{
  imports = [ ./bottom.nix ./graphics.nix ./kitty ];
  home.packages = with pkgs; [ brave firefox rofi ];
  home.file.".config/rofi".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/rofi";
}
