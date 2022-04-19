{ config, pkgs, libs, ... }:
{
  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    initExtra = "bindkey -s ^f \"tmux-sessionizer\\n\"";
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      edit = "sudo lvim /etc/nixos/configuration.nix";

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
