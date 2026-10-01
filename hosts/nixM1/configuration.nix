{ config, lib, pkgs, ... }:

{
  nix = {
    # package = pkgs.nixUnstable;
    extraOptions = ''
      extra-platforms = aarch64-darwin x86_64-darwin
      experimental-features = nix-command flakes
    '';
  };

  system.defaults =
    {
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
        AppleInterfaceStyle = "Dark";
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        _HIHideMenuBar = false;
      };

      dock = {
        autohide = true;
        mru-spaces = false;
        orientation = "bottom";
        showhidden = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        ShowPathbar = true;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };

  # Screen saver + display sleep. nix-darwin has no first-class options for
  # these: the screen saver idle time is a per-user ByHost preference (needs
  # `defaults -currentHost`, which system.defaults can't emit), and display
  # sleep per power source needs pmset. Applied on every activation.
  system.activationScripts.postActivation.text = ''
    # Start screen saver after 30 min of idle (per-user ByHost preference).
    launchctl asuser "$(id -u -- scott)" sudo --user=scott -- \
      defaults -currentHost write com.apple.screensaver idleTime -int 1800

    # Blank the display after 60 min on AC power, 10 min on battery.
    pmset -c displaysleep 60
    pmset -b displaysleep 10
  '';

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;
  system.stateVersion = 5;
  system.primaryUser = "scott";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # coreutils
    git
    gnupg
    vim
    zsh
  ];

  services.yabai.enable = false;
  services.yabai.package = pkgs.yabai;
  services.skhd.enable = false;
  services.skhd.package = pkgs.skhd;

  # AeroSpace window manager (replaces the Homebrew cask + ~/.aerospace.toml).
  # NOTE: this nix-darwin revision exposes the module as `services.aerospace`
  # (newer nix-darwin moved it to `programs.aerospace`). Enabling it installs
  # the nixpkgs package (AeroSpace.app + aerospace CLI) and a launchd user
  # agent that auto-starts AeroSpace at login with the generated config
  # passed via --config-path.
  services.aerospace = {
    enable = true; # Disabled while trying Rift; retain settings for switching back.
    settings = {
      "config-version" = 2;
      "enable-normalization-flatten-containers" = false;
      "enable-normalization-opposite-orientation-for-nested-containers" = false;
      "on-focused-monitor-changed" = [ "move-mouse monitor-lazy-center" ];
      "focus-follows-mouse".enabled = false;
      "persistent-workspaces" = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];

      mode = {
        main.binding = {
          "alt-enter" = ''exec-and-forget osascript -e '
    tell application "Ghostty"
        do script
        activate
    end tell'
          '';
          "alt-j" = "focus --boundaries-action wrap-around-the-workspace left";
          "alt-k" = "focus --boundaries-action wrap-around-the-workspace down";
          "alt-l" = "focus --boundaries-action wrap-around-the-workspace up";
          "alt-semicolon" = "focus --boundaries-action wrap-around-the-workspace right";

          "alt-shift-j" = "move left";
          "alt-shift-k" = "move down";
          "alt-shift-l" = "move up";
          "alt-shift-semicolon" = "move right";

          "alt-h" = "split horizontal";
          "alt-v" = "split vertical";

          "alt-f" = "fullscreen";

          "alt-slash" = "layout tiles horizontal vertical";
          "alt-comma" = "layout accordion horizontal vertical";

          "alt-minus" = "resize smart -50";
          "alt-equal" = "resize smart +50";

          "alt-shift-space" = "layout floating tiling";

          "alt-shift-tab" = "move-workspace-to-monitor --wrap-around next";

          "alt-1" = "workspace 1";
          "alt-2" = "workspace 2";
          "alt-3" = "workspace 3";
          "alt-4" = "workspace 4";
          "alt-5" = "workspace 5";
          "alt-6" = "workspace 6";
          "alt-7" = "workspace 7";
          "alt-8" = "workspace 8";
          "alt-9" = "workspace 9";
          "alt-0" = "workspace 10";

          "alt-shift-1" = "move-node-to-workspace 1";
          "alt-shift-2" = "move-node-to-workspace 2";
          "alt-shift-3" = "move-node-to-workspace 3";
          "alt-shift-4" = "move-node-to-workspace 4";
          "alt-shift-5" = "move-node-to-workspace 5";
          "alt-shift-6" = "move-node-to-workspace 6";
          "alt-shift-7" = "move-node-to-workspace 7";
          "alt-shift-8" = "move-node-to-workspace 8";
          "alt-shift-9" = "move-node-to-workspace 9";
          "alt-shift-0" = "move-node-to-workspace 10";

          "alt-shift-c" = "reload-config";

          "alt-r" = "mode resize";
        };

        resize.binding = {
          h = "resize width -50";
          j = "resize height +50";
          k = "resize height -50";
          l = "resize width +50";
          enter = "mode main";
          esc = "mode main";
        };
      };
    };
  };

  nix.settings.sandbox = true;
  nix.settings.extra-sandbox-paths = [ "/private/tmp" "/private/var/tmp" "/usr/bin/env" ];

  programs.nix-index.enable = true;

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  environment.etc."nix/user-sandbox.sb".text = ''
    (version 1)
    (allow default)
    (deny file-write*
          (subpath "/nix"))
    (allow file-write*
           (subpath "/nix/var/nix/gcroots/per-user")
           (subpath "/nix/var/nix/profiles/per-user"))
    (allow process-exec
          (literal "/bin/ps")
          (with no-sandbox))
  '';

  programs.bash.completion.enable = true;

  environment.variables.LANG = "en_US.UTF-8";

  nix.nrBuildUsers = 32;
}
