# .zshenv

# exports
export EDITOR=nvim
export SHELL=$(which zsh)
export MANPAGER="less -R --use-color -Dd+r -Du+b -DS+ky -DP+kg -DE+kR"
export VISUAL=/bin/vim
export DOTFILES=$HOME/nixos
export PROJECTS_DIR=$HOME/work
export NPM_PREFIX_DIR=$HOME/.node_modules
export XDG_DATA_HOME="${HOME}/.local/share"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
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
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export GRADLE_HOME="$HOME/.local/bin/gradle-6.9.1"
export PATH="$PATH:$HOME/bin/flutter/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"
# export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/Library/Android/sdk"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$GRADLE_HOME/bin"
export PATH="$PATH:$CARGO_HOME/bin"
export PATH="$PATH:$ANDROID_SDK_ROOT/emulator"
export PATH="$PATH:$ANDROID_SDK_ROOT/tools"
export PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
