# .zshenv

# exports
export EDITOR=nvim
export MANPAGER="less -R --use-color -Dd+r -Du+b -DS+ky -DP+kg -DE+kR"
export VISUAL=/bin/vim
export DOTFILES=$HOME/nixos
export PROJECTS_DIR=$HOME/work
export NPM_PREFIX_DIR=$HOME/.node_modules
# export NVM_DIR="$HOME/.nvm"


typeset -U PATH path

path=("$HOME/.bin" "$HOME/.local/bin" "$HOME/.emacs.d/bin" "$HOME/.cache/npm/bin" "$NPM_PREFIX_DIR/bin" "$path[@]")
export PATH

if [ "$(uname)" = 'Darwin' ]; then
  export PATH="$PATH:/run/current-system/sw/bin"
  export PATH="$PATH:$HOME/.nix-profile/bin"
fi
if [ -d "$HOME/n" ]; then
  export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
fi

export PATH=$N_PREFIX/bin:$PATH
