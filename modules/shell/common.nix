{ config, pkgs, libs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ./dircolors.nix
    ./git.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    bottom
    exa
    fd
    ffmpeg
    fzf
    github-cli
    gnumake
    ranger
    (ripgrep.override { withPCRE2 = true; })
    tmux
    unzip
    wget
    xclip

    awscli
    brotli
    cmake
    curl
    htop
    jq
    kubectl
    lsof
    nix-index
    stow
    tabnine
    tree
    tmux
    unzip
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/bin";
  home.file.".tmux.conf".text = import ./tmux.nix;
}
