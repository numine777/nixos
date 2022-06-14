{ config, pkgs, libs, ... }:
{
  programs.fish = {
    enable = true;
    # plugins = [
    #   {
    #     name = "oh-my-fish";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "oh-my-fish";
    #       repo = "oh-my-fish";
    #       rev = "92a572d8cdfdf5b219269d59210b8a28f6cd6616";
    #       sha256 = "bb1f4025934600ea6feef2ec11660e17e2b6449c5a23c033860aed712ad328c9";
    #     };
    #   }
    # ];
    shellInit = "starship init fish | source";
  };
  # home.file.".config/fish".source =
  #   config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/fish";
}
