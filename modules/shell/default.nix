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
    awscli
    bottom
    brightnessctl
    brotli
    cmake
    curl
    efibootmgr
    exa
    fd
    feh
    ffmpeg
    fortune
    fzf
    github-cli
    glibc
    gnumake
    hsetroot
    htop
    jq
    k9s
    kubectl
    lazygit
    lazydocker
    lm_sensors
    lsof
    maim
    ncdu
    nix-index
    nnn
    pamixer
    pass
    playerctl
    ranger
    (ripgrep.override { withPCRE2 = true; })
    slop
    stow
    tabnine
    tree
    tmux
    unzip
    wget
    xclip
    xorg.xkbcomp
    zoxide
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/bin";
  home.file.".tmux.conf".text = import ./tmux.nix;
}
