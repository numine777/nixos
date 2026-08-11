''
  # Mirrors ~/.tmux.conf (see ./tmux.nix) where herdr has an equivalent.
  # Herdr-specific defaults (prefix+shift+r reload, resize mode on prefix+r,
  # sidebar, agent panel, vi-style copy mode, native clipboard) are left alone.

  [keys]
  # tmux: set -g prefix C-a
  prefix = "ctrl+a"
  # tmux default detach (prefix d); herdr's default is prefix+q
  detach = "prefix+d"
  # tmux: bind Enter copy-mode (keep herdr's prefix+[ too)
  copy_mode = ["prefix+[", "prefix+enter"]
  # tmux-pain-control: h/j/k/l pane movement (keep herdr's ctrl+arrows too)
  focus_pane_left = ["prefix+h", "ctrl+left"]
  focus_pane_down = ["prefix+j", "ctrl+down"]
  focus_pane_up = ["prefix+k", "ctrl+up"]
  focus_pane_right = ["prefix+l", "ctrl+right"]
  # tmux-pain-control: `-` splits horizontally; `|` isn't bindable in herdr,
  # so vertical split stays on herdr's default prefix+v
  split_horizontal = "prefix+minus"
  # tmux: rename window on prefix+, (keep herdr's prefix+shift+t too)
  rename_tab = ["prefix+comma", "prefix+shift+t"]
  # tmux: bind -n S-Left/S-Right previous/next window
  previous_tab = ["prefix+p", "shift+left"]
  next_tab = ["prefix+n", "shift+right"]
  # tmux: bind -n S-Up/S-Down toggles the status bar; sidebar is the closest thing
  toggle_sidebar = ["prefix+b", "shift+up", "shift+down"]
  # tmux: base-index 1
  switch_tab = "prefix+1..9"

  # tmux: bind -r i run-shell "tmux neww tmux-cht.sh"
  [[keys.command]]
  key = "prefix+i"
  type = "pane"
  command = "tmux-cht.sh"
  description = "cheat sheet"

  [theme]
  # status bar colors in tmux are gruvbox-material
  name = "gruvbox"

  [theme.custom]
  # tmux: status-style bg=default (transparent status bar)
  panel_bg = "reset"
  # tmux: active window highlight #ea6962
  accent = "#ea6962"

  [ui]
  # tmux: set-option -g mouse on
  mouse_capture = true
''
