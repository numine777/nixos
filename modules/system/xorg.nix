{ config, pkgs, ... }:
{
  services.xserver.  services.xserver = {
    enable = true;
    # displayManager.lightdm = {
    #   enable = true;
    #   greeters.gtk.enable = true;
    # };
    extraLayouts.real-prog-dvorak = {
      description = "Real Programmers Dvorak";
      languages = [ "eng" ];
      symbolsFile = ./symbols/real-prog-dvorak;
    };

    displayManager = {
      # defaultSession = "xfce+i3";
      sddm.enable = true;
      defaultSession = "none+awesome";
    };
    libinput.enable = true;
    layout = "real-prog-dvorak";
    windowManager = {
      awesome = {
        enable = true;
        package = pkgs.awesome-git;
      };
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
  };
}
