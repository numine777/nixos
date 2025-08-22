{ config, pkgs, libs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ./dircolors.nix
    ./fish.nix
    ./nush.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    bottom
    delta
    eza
    fd
    ffmpeg
    fzf
    github-cli
    gnumake
    keychain
    ranger
    (ripgrep.override { withPCRE2 = true; })
    tmux
    unzip
    wget
    xclip
    zoxide

    awscli
    brotli
    # cmake
    curl
    gdu
    htop
    jq
    kubectl
    lsof
    nix-index
    nushell
    starship
    stow
    tabnine
    tldr
    tree
    tmux
    unzip
    zellij
    mergiraf
    difftastic
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/bin";
  home.file.".tmux.conf".text = import ./tmux.nix;
}
