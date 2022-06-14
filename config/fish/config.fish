# ~/.config/fish/config.fish: DO NOT EDIT -- this file has been generated
# automatically by home-manager.

# Only execute this file once per shell.
set -q __fish_home_manager_config_sourced; and exit
set -g __fish_home_manager_config_sourced 1

set --prepend fish_function_path /nix/store/zd3s52glkkl82wbj7v4mfh030cs701r4-fishplugin-foreign-env-unstable-2020-02-09/share/fish/vendor_functions.d
fenv source /Users/scott/.nix-profile/etc/profile.d/hm-session-vars.sh > /dev/null
set -e fish_function_path[1]

eval (/nix/store/w5m17zyg7v1s2j85b1rmy5v9x9bqmgls-coreutils-9.1/bin/dircolors -c ~/.dir_colors)


status --is-login; and begin

  # Login shell initialisation
  

end

status --is-interactive; and begin

  # Abbreviations
  

  # Aliases
  

  # Interactive shell intialisation
  # add completions generated by Home Manager to $fish_complete_path
begin
  set -l joined (string join " " $fish_complete_path)
  set -l prev_joined (string replace --regex "[^\s]*generated_completions.*" "" $joined)
  set -l post_joined (string replace $prev_joined "" $joined)
  set -l prev (string split " " (string trim $prev_joined))
  set -l post (string split " " (string trim $post_joined))
  set fish_complete_path $prev "/Users/scott/.local/share/fish/home-manager_generated_completions" $post
end


end

starship init fish | source