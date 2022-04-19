{ config, pkgs, libs, ... }:
{
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
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    brave
    mosh
    synergy
    awscli
    brotli
    cargo
    cmake
    curl
    direnv
    efibootmgr
    gcc
    git
    glibc
    gnupg
    htop
    postman
    jq
    kubectl
    lsof
    nix-index
    nodejs
    openssl_3_0
    picom
    python310
    ripgrep
    rofi
    rust-analyzer
    rustc
    rustup
    rustfmt
    slack-dark
    shellcheck
    stow
    sumneko-lua-language-server
    tabnine
    tree
    unzip
    xorg.xkbcomp
    xscreensaver
    yarn
  ];

  # not big enough for their own modules
  home.file.".bin".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bin";
  home.file.".tmux.conf".text = import ./tmux.nix;
}
