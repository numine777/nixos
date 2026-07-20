{ config, pkgs, libs, ... }:
{
  imports = [ ./bottom.nix ./graphics.nix ./irssi.nix ./kitty ./mail.nix ./alacritty.nix ./ghostty.nix ./wezterm.nix ];
  home.packages = with pkgs; [
    bat
    k9s
    lazygit
    lazydocker
    # niv
    nnn
    obsidian
    # nemo
    # slack
    tree-sitter
  ];
}
