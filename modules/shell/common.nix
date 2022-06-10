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
    direnv
    htop
    postman
    jq
    kubectl
    lsof
    nix-index
    slack-dark
    stow
    tabnine
    tree
    unzip
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/bin";
  home.file.".tmux.conf".text = import ./tmux.nix;
}
