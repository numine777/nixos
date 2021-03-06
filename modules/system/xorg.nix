{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    # displayManager.lightdm = {
    #   enable = true;
    #   greeters.gtk.enable = true;
    # };
    extraLayouts.real-prog-dvorak = {
      description = "Real Programmers Dvorak";
      languages = [ "eng" ];
      # symbolsFile = "${config.home.homeDirectory}/nixos/modules/system/symbols/real-prog-dvorak";
      symbolsFile = ./symbols/real-prog-dvorak;
    };

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.mate.enable = true;
    libinput.enable = true;
    layout = "real-prog-dvorak";
    desktopManager = {
      gnome.enable = true;
    };
    windowManager = {
      awesome = {
        enable = true;
        package = pkgs.awesome-git;
      };
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
      berry.enable = true;
      herbstluftwm.enable = true;
    };
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.slock.enable = true;
}
