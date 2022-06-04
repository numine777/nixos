{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Other Modules
      ../../modules/system/env.nix
      ../../modules/system/fonts.nix
      ../../modules/system/sound.nix
      ../../modules/system/xorg.nix
    ];
  nixpkgs.config.allowUnfree = true; 
  virtualisation.vmware.guest.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.configurationLimit = 5;

  # use latest kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  time.timeZone = "America/Chicago";

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.ens33.useDHCP = true;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  hardware.bluetooth.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs.gnupg.agent.enable = true;

  users.users.scott = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
    initialPassword = "metallica7827";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = false;
  };

  environment.binsh = "${pkgs.dash}/bin/dash";

  environment.systemPackages = with pkgs; [
    busybox
    coreutils
    gcc
    gnupg
    pinentry
    usbutils
    vim
    zsh
  ];

  nix = {
    package = pkgs.nixUnstable;
    trustedUsers = [ "root" "scott" "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  virtualisation.docker.enable = true;
  services.openssh.enable = true;
  programs.mosh.enable = true;
  networking.firewall.allowedUDPPorts = [ 60001 ];
  system.stateVersion = "21.11";
}
