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

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme1n1";
  boot.loader.grub.configurationLimit = 5;
  hardware.system76.kernel-modules.enable = true;
  hardware.system76.enableAll = true;

  # use latest kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  time.timeZone = "America/Chicago";

  networking = {
    hostName = "nixosThelio";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.enp68s0.useDHCP = true;
    interfaces.wlo2.useDHCP = true;
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
  services.openvpn.servers = {
    adytonVPN = {
      config = '' 
client
route-nopull
route 172.31.0.0 255.255.0.0
dev tun
proto udp
remote remote.themel.io 1194
resolv-retry infinite
nobind
user nobody
group nobody
persist-key
persist-tun
verb 3
mute 20
ca /home/scott/swalls/ca.crt
cert /home/scott/swalls/swalls.crt
key /home/scott/swalls/swalls.key
    '';
    };
  };
  programs.mosh.enable = true;
  networking.firewall.allowedTCPPorts = [ 24800 ];
  networking.firewall.allowedUDPPorts = [ 60001 ];
  system.stateVersion = "21.11";
}
