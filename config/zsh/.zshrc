# .zshrc

### Added by Zinit's installer
declare -A ZINIT
ZINIT[HOME_DIR]=$HOME/.zsh/zinit
ZINIT[ZCOMPDUMP_PATH]=${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump-$ZSH_VERSION

if [[ ! -f ${ZINIT[HOME_DIR]}/bin/zinit.zsh ]]; then
  print -P "%F{blue}▓▒░ %F{yellow}Installing %F{blue}DHARMA%F{yellow} Initiative Plugin Manager (%F{blue}zdharma/zinit%F{yellow})…%f"
  mkdir -p "${ZINIT[HOME_DIR]}" && chmod g-rwX "${ZINIT[HOME_DIR]}"
  git clone https://github.com/zdharma-continuum/zinit "${ZINIT[HOME_DIR]}/bin" && {
    print -P "%F{blue}▓▒░ %F{34}Installation successful.%f%b" ||
    print -P "%F{red}▓▒░ The clone has failed.%f%b"
  }
fi

source "${ZINIT[HOME_DIR]}/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

## PLUGINS
zinit wait lucid light-mode for \
  atinit"
    typeset -gA FAST_HIGHLIGHT
    FAST_HIGHLIGHT[git-cmsg-len]=100
    ZINIT[COMPINIT_OPTS]=-C
    zicompinit
    zicdreplay
  " \
    zdharma-continuum/fast-syntax-highlighting \
  blockf atpull'zinit creinstall -q .' \
  atload'
    # eval "$(dircolors)"
    zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}" "ma=38;5;7;7;1"
    zstyle ":completion:*:*:kill:*:processes" list-colors "=(#b) #([0-9]#) ([0-9a-z-]#)*=36=0=01"
  ' \
    zsh-users/zsh-completions \
  atinit"
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30000
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_COMPLETION_IGNORE='_*|pre(cmd|exec)|sudo pacman -S*|pacman -S*|paru -S*|yay -S*|\)\*'
  " \
    zsh-users/zsh-autosuggestions \
  atload"
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='underline'
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
  " \
    zsh-users/zsh-history-substring-search \

zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit promptinit
compinit -i
promptinit

# zsh options
# setopt case_glob              # Use Case-Insensitve Globbing.
setopt globdots                 # Glob Dotfiles As Well.
setopt extendedglob             # Use Extended Globbing.
setopt auto_cd                  # no need to specify cd
setopt correct                  # spelling correction
setopt interactivecomments      # Ignore lines prefixed with '#'
unsetopt beep                   # Hush.
setopt rc_quotes                # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'

# Completion Options.
setopt complete_in_word         # Complete From Both Ends Of A Word.
setopt always_to_end            # Move Cursor To The End Of A Completed Word.
setopt path_dirs                # Perform Path Search Even On Command Names With Slashes.
setopt auto_menu                # Show Completion Menu On A Successive Tab Press.
setopt auto_list                # Automatically List Choices On Ambiguous Completion.
setopt auto_param_slash         # If Completed Parameter Is A Directory, Add A Trailing Slash.
# setopt menu_complete            # Do Not Autoselect The First Completion Entry.

# zstyle
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZINIT[HOME_DIR]}/.zcompcache"
zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*:*:*:*:processes' command'ps -u $USER -o pid,user,comm,cmd -w -w'
zstyle ':completion:*:exa' file-sort modification
zstyle ':completion:*:exa' sort true


# History file configuration
HISTFILE="$HOME/.zsh_history"
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt APPENDHISTORY
setopt EXTENDED_HISTORY          # record timestamp of command in HISTFILE
setopt HIST_EXPIRE_DUPS_FIRST    # delete duplicates first when HISTFILE size exceeds HISTSIZE
# setopt hist_ignore_dups          # Don't record an entry that was just recorded again
# setopt hist_find_no_dups         # Do not display a line previously found
# setopt hist_ignore_space         # ignore commands that start with space
# setopt INC_APPEND_HISTORY        # add commands to HISTFILE in order of execution

autoload -U add-zsh-hook

# aliases
source "$HOME/.zsh/aliases.zsh"

# better url management
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# history substring search
zle -N history-substring-search-up
zle -N history-substring-search-down

## keybindings
bindkey -v                                        # vim keybindings
bindkey '\e[A' history-substring-search-up        # up
bindkey '\eOA' history-substring-search-up        # up
bindkey '\e[B' history-substring-search-down      # down
bindkey '\eOB' history-substring-search-down      # down
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey -s '^f' "tmux-sessionizer\n"

# # prompt
# precmd() {
#     precmd() {
#         echo
#     }
# }
eval "$(zoxide init zsh)"

autoload -U promptinit && promptinit
setopt PROMPTSUBST
# B.
zinit wait lucid for \
  OMZL::git.zsh \
  atload"unalias grv" \
  OMZP::git

PS1="READY >" # provide a simple prompt till the theme loads

# C.
zinit wait'!' lucid for \
  OMZL::prompt_info_functions.zsh \
  OMZL::spectrum.zsh \
  OMZL::theme-and-appearance.zsh \
  OMZT::robbyrussell

# D.
zinit wait lucid for \
  atinit"zicompinit; zicdreplay" \
  z-shell/fast-syntax-highlighting \
  OMZP::colored-man-pages \
  as"completion" \
  OMZP::docker/_docker \
  OMZP::bazel/_bazel \
  OMZP::fzf

_prompt_nix() {
  [ -z "$IN_NIX_SHELL" ] || echo "%F{yellow}%B[''${name:+$name}]%b%f "
}
RPS1='$(_prompt_nix)%F{blue}%~%f'
if [ -n "$IN_NIX_SANDBOX" ]; then
  PS1+='%F{red}[sandbox]%f '
fi
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(direnv hook zsh)"
# Copied from "direnv hook zsh" output:
_direnv_hook_enabled=1
_direnv_hook() {
  if [ $_direnv_hook_enabled -eq 1 ]; then
      eval "$("direnv" export zsh)";
      # eval "$(direnv export $SHELL 2> >( egrep -v -e '^direnv: (loading|export|unloading)' ))";
  fi
}
direnv-freeze() {
    if [[ $# -eq 1 ]]; then
        echo "direnv: setting up shell environment for directory $1"
        pushd "$1" > /dev/null || return 1
        eval "$(direnv export zsh)"
        popd > /dev/null
    fi
    echo "direnv: disabling shell hook; use direnv-thaw to enable again"
    _direnv_hook_enabled=0
}
direnv-thaw() {
    echo "direnv: enabling shell hook"
    _direnv_hook_enabled=1
}

# complete -F _cd direnv-freeze

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
