{ config, pkgs, ... }:
{
  sound.enable = true;
  boot.extraModprobeConfig = ''
    options snd slots=snd-card-audiopci
  '';
  boot.blacklistedKernelModules = [ "snd_pcsp" ];
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa = {
  #     enable = true;
  #     support32Bit = true;
  #   };
  #   pulse.enable = true;
  # };
}
