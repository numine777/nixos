''
  # unbind C-b
  set -g prefix C-a
  bind C-a send-prefix
  setw -g mode-keys vi
  set -g base-index 1
  setw -g pane-base-index 1
  # cheat sheet
  bind -r i run-shell "tmux neww tmux-cht.sh"
  # Kitty
  # set -g default-terminal "xterm-kitty"
  # set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
  # set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
  # vim style yank
  bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -sel clip > /dev/null"
  bind-key p run "xclip -o -sel clip | tmux load-buffer - ; tmux paste-buffer"
  # Mouse
  set-option -g mouse on
  # reload tmux config
  bind r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
  # toggle status bar
  bind-key -n S-Up set-option -g status
  bind-key -n S-Down set-option -g status
  # move between windows
  bind-key -n S-Left previous-window
  bind-key -n S-Right next-window
  # Plugins
  set -g @plugin 'tmux-plugins/tpm'
  set -g @plugin 'tmux-plugins/tmux-sensible'
  set -g @plugin 'tmux-plugins/tmux-pain-control'
  set -g @plugin 'tmux-plugins/tmux-yank'
  set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
  set -g @plugin 'fcsonline/tmux-thumbs'
  # Basic status bar colors
  set-option -g status-style fg=white,bg=default
  # Left side of status bar
  set-option -g status-left-length 100
  set-option -g status-left "#[fg=black,bg=cyan] #S #[fg=default,bg=default]         "
  # Window status
  set-option -g window-status-format "#[fg=white,bg=#3c3836] #I #[fg=white,bg=#brightblack] #W "
  set-option -g window-status-current-format "#[fg=black,bg=red] #I #[fg=white,bg=#brightblack] #W "
  set-option -g window-status-separator "  "
  set-option -g status-justify centre
  # Right side of status bar
  set-option -g status-right-length 100
  set-option -g status-right "#[bg=black] #(status music) #[bg=default]  #[bg=#brightblack] #(status bat) #[bg=default] #[bg=#brightblack] %a, %d %b #[bg=default] #[bg=#brightblack] %R "
  # Pane border
  set-option -g pane-border-style bg=default
  set-option -g pane-border-style fg=brightblack
  set-option -g pane-active-border-style bg=default
  set-option -g pane-active-border-style fg=white
  # Pane number indicator
  set-option -g display-panes-colour brightblack
  set-option -g display-panes-active-colour brightwhite
  # Clock mode
  set-option -g clock-mode-colour white
  set-option -g clock-mode-style 24
  # Message
  set-option -g message-style bg=default
  set-option -g message-style fg=green
  # run '~/.tmux/plugins/tpm/tpm'
  # DONT WRITE ANYTHING AFTER THIS LINE
  # vim: ft=tmux
''
