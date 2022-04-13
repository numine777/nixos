{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "scott";
  home.homeDirectory = "/home/scott";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";


      luamake = "/home/scott/lua-language-server/3rd/luamake/luamake";

      adyton = ". /home/scott/scripts/ssh/mountAdyton.sh";
      polygrok = ". /home/scott/scripts/ssh/mountMac.sh";
      vim = "lvim";
      adytonVPN = ". /home/scott/scripts/vpn/adytonVPN.sh";
      emulator = "/home/scott/Android/Sdk/emulator/emulator";
      phone = "emulator -avd Pixel_3a_API_30_x86 -dns-server 8.8.8.8";
    };
    localVariables = {
      ANDROID_SDK_ROOT = "/home/scott/Android/Sdk";
      ANDROID_HOME = "/home/scott/Android/Sdk";
      PATH =
        "$PATH:/home/scott/bin/depot_tools:/home/scott/.local/bin:/home/scott/go/bin:/home/scott/.android/:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools:$HOME/bin/flutter/bin:$HOME/.poetry/bin:$HOME/.local/.npm-global/bin";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      ];
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}
