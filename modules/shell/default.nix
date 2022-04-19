{ config, pkgs, libs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ./dircolors.nix
    ./git.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    acpi
    alsa-utils
    bottom
    brightnessctl
    exa
    fd
    feh
    ffmpeg
    fortune
    fzf
    github-cli
    gnumake
    hsetroot
    lm_sensors
    maim
    ncdu
    pamixer
    pass
    playerctl
    ranger
    (ripgrep.override { withPCRE2 = true; })
    slop
    tmux
    unzip
    wget
    xclip
    zoxide

    _1password-gui
    mosh
    synergy
    awscli
    brotli
    cmake
    curl
    dconf
    direnv
    efibootmgr
    glibc
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
    xorg.xkbcomp
    xscreensaver
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/bin";
  home.file.".tmux.conf".text = import ./tmux.nix;
}
