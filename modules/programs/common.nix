{ config, pkgs, libs, ... }:
{
  imports = [ ./bottom.nix ./graphics.nix ./irssi.nix ./kitty ./mail.nix ./alacritty.nix ./wezterm.nix ];
  home.packages = with pkgs; [
    bat
    k9s
    lazygit
    lazydocker
    # niv
    nnn
    # obsidian
    # slack
    tree-sitter
  ];
}
