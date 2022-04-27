{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.desktop.windowManager.i3;
in
{
  options.modules.desktop.windowManager.i3 = {
    enable = mkEnableOption "i3";
  };

  config = mkIf cfg.enable {
    home.file.".config/i3/config".text = ''
      # i3 config

      # mod key
      set $mod Mod4
      floating_modifier $mod

      # font
      font pango:JetBrainsMono Nerd Font 9

      # gaps
      gaps inner 10
      gaps outer 10

      # decorations
      title_align center

      default_border pixel 0

      set $fg_focus   #abb2bf
      set $bg_focus   #c678dd
      set $fg_unfocus #545862
      set $bg_unfocus #282c34

      #                        Border       Background   Foreground   Indicator    Child Border
      client.focused           $bg_focus    $bg_focus    $fg_focus    $bg_focus    $bg_focus
      client.unfocused         $bg_unfocus  $bg_unfocus  $fg_unfocus  $bg_unfocus  $bg_unfocus
      client.focused_inactive  $bg_unfocus  $bg_unfocus  $fg_unfocus  $bg_unfocus  $bg_unfocus
      client.urgent            $bg_focus    $bg_focus    $fg_focus    $bg_focus    $bg_focus

      # start a terminal
      bindsym $mod+Shift+Return exec kitty

      # keybinding for apps that i use often
      bindsym $mod+Shift+b exec brave
      bindsym $mod+Shift+e exec emacs

      # kill focused window
      bindsym $mod+Shift+c kill

      # rofi
      bindsym $mod+p exec --no-startup-id rofi -show drun

      # Use pactl to adjust volume in PulseAudio.
      bindsym XF86AudioRaiseVolume exec --no-startup-id setvol +5%
      bindsym XF86AudioLowerVolume exec --no-startup-id setvol 5%- 
      bindsym XF86AudioMute exec --no-startup-id setvol 0%

      # use brightnessctl to adjust actual brightness
      bindsym XF86MonBrightnessUp exec --no-startup-id brightnessctl set +10%
      bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl set 10%-
      bindsym Ctrl+XF86MonBrightnessUp exec --no-startup-id brightnessctl set +5%
      bindsym Ctrl+XF86MonBrightnessDown exec --no-startup-id brightnessctl set 5%-

      # use xrandr to rotate the screen
      bindsym Ctrl+$mod+Left exec --no-startup-id xrandr --output eDP-1 --rotate left
      bindsym Ctrl+$mod+Right exec --no-startup-id xrandr --output eDP-1 --rotate right
      bindsym Ctrl+$mod+Down exec --no-startup-id xrandr --output eDP-1 --rotate inverted
      bindsym Ctrl+$mod+Up exec --no-startup-id xrandr --output eDP-1 --rotate normal

      # screenshot
      bindsym Print exec --no-startup-id scr screen
      bindsym Ctrl+Print exec --no-startup-id scr window
      bindsym Shift+Print exec --no-startup-id scr selection
      bindsym $mod+Print exec --no-startup-id scr screentoclip
      bindsym $mod+Ctrl+Print exec --no-startup-id scr windowtoclip
      bindsym $mod+Shift+Print exec --no-startup-id scr selectiontoclip

      # change focus
      # bindsym $mod+j focus left
      # bindsym $mod+k focus down
      # bindsym $mod+l focus up
      # bindsym $mod+semicolon focus right

      # alternatively, you can use the cursor keys:
      bindsym $mod+Left focus left
      bindsym $mod+Down focus down
      bindsym $mod+Up focus up
      bindsym $mod+Right focus right

      # move focused window
      bindsym $mod+Shift+j move left
      bindsym $mod+Shift+k move down
      bindsym $mod+Shift+l move up
      bindsym $mod+Shift+semicolon move right

      # alternatively, you can use the cursor keys:
      bindsym $mod+Shift+Left move left
      bindsym $mod+Shift+Down move down
      bindsym $mod+Shift+Up move up
      bindsym $mod+Shift+Right move right

      # split in horizontal orientation
      bindsym $mod+h split h

      # split in vertical orientation
      bindsym $mod+v split v

      # enter fullscreen mode for the focused container
      bindsym $mod+f fullscreen toggle

      # change container layout (stacked, tabbed, toggle split)
      bindsym $mod+s layout stacking
      bindsym $mod+w layout tabbed
      bindsym $mod+e layout toggle split

      # toggle tiling / floating
      bindsym $mod+Shift+space floating toggle

      # change focus between tiling / floating windows
      bindsym $mod+space focus mode_toggle

      # focus the parent container
      bindsym $mod+a focus parent

      # focus the child container
      # bindsym $mod+d focus child

      # Define names for default workspaces for which we configure key bindings later on.
      # We use variables to avoid repeating the names in multiple places.
      set $ws1 "1"
      set $ws2 "2"
      set $ws3 "3"
      set $ws4 "4"
      set $ws5 "5"
      set $ws6 "6"
      set $ws7 "7"
      set $ws8 "8"
      set $ws9 "9"
      set $ws10 "10"

      # switch to workspace
      bindsym $mod+1 workspace number $ws1
      bindsym $mod+2 workspace number $ws2
      bindsym $mod+3 workspace number $ws3
      bindsym $mod+4 workspace number $ws4
      bindsym $mod+5 workspace number $ws5
      bindsym $mod+6 workspace number $ws6
      bindsym $mod+7 workspace number $ws7
      bindsym $mod+8 workspace number $ws8
      bindsym $mod+9 workspace number $ws9
      bindsym $mod+0 workspace number $ws10

      # move focused container to workspace
      bindsym $mod+Shift+1 move container to workspace number $ws1
      bindsym $mod+Shift+2 move container to workspace number $ws2
      bindsym $mod+Shift+3 move container to workspace number $ws3
      bindsym $mod+Shift+4 move container to workspace number $ws4
      bindsym $mod+Shift+5 move container to workspace number $ws5
      bindsym $mod+Shift+6 move container to workspace number $ws6
      bindsym $mod+Shift+7 move container to workspace number $ws7
      bindsym $mod+Shift+8 move container to workspace number $ws8
      bindsym $mod+Shift+9 move container to workspace number $ws9
      bindsym $mod+Shift+0 move container to workspace number $ws10

      # reload the configuration file
      bindsym $mod+Control+r reload
      # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
      bindsym $mod+Shift+r restart
      # exit i3 (logs you out of your X session)
      bindsym $mod+Shift+q exec "i3-msg exit"

      # resize window (you can also use the mouse for that)
      mode "resize" {
              # These bindings trigger as soon as you enter the resize mode

              # Pressing left will shrink the window’s width.
              # Pressing right will grow the window’s width.
              # Pressing up will shrink the window’s height.
              # Pressing down will grow the window’s height.
              bindsym j resize shrink width 10 px or 10 ppt
              bindsym k resize grow height 10 px or 10 ppt
              bindsym l resize shrink height 10 px or 10 ppt
              bindsym semicolon resize grow width 10 px or 10 ppt

              # same bindings, but for the arrow keys
              bindsym Left resize shrink width 5 px or 5 ppt
              bindsym Down resize grow height 5 px or 5 ppt
              bindsym Up resize shrink height 5 px or 5 ppt
              bindsym Right resize grow width 5 px or 5 ppt

              # back to normal: Enter or Escape or $mod+r
              bindsym Return mode "default"
              bindsym Escape mode "default"
              bindsym $mod+r mode "default"
      }

      bindsym $mod+r mode "resize"

      # bar
      exec --no-startup-id tint2 -c ~/.config/tint2/nord

      # picom
      exec --no-startup-id picom

      # set wallpaper (ft. feh)
      exec --no-startup-id ~/.fehbg
    '';
  };
}
