{ config, pkgs, libs, ... }:
{
  home.file.".zsh".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/zsh/.zsh";
  home.file.".zshrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/zsh/.zshrc";
  home.file.".zshenv".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/zsh/.zshenv";
}
