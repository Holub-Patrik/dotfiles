# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=0
setopt extendedglob nomatch 
unsetopt beep notify auto_list list_ambiguous menu_complete
bindkey -e
# fpath+=($HOME/.zsh/pure)

zstyle :compinstall filename '/home/holubpat/.zshrc'
# enable completion
autoload -U compinit; compinit

# arch linux wiki says to do this
if ! [[ -f $XDG_RUNTIME_DIR/ssh-agent.env ]]; then
  touch $XDG_RUNTIME_DIR/ssh-agent.env
fi

# start ssh agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [ ! -f "$SSH_AUTH_SOCK" ]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# now I know why selecet must equal -1
# the select options says when to show the menu
# The number of mathes can never be -1 so it never will open the menu
# ---
# added complete-options and complete
zstyle ':completion:*' menu select=-1 complete-options true complete true
bindkey '^[[Z' reverse-menu-complete

function clear-screen-and-scrollback() {
  clear && printf '\e[3J'
  zle && zle .reset-prompt && zle -R
}
zle -N clear-screen-and-scrollback
bindkey '^L' clear-screen-and-scrollback

# add the odin binary
export PATH="$PATH:$HOME/Odin"
export GIT_EDITOR="nvim"

# Set up fzf key bindings and fuzzy completion
# source <(fzf --zsh)
# Setup my own (fd is more flexible and faster than the builtin)
# Also this way I don't load extra keybinds

cd-widget-normal() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(fd -t d | fzf --reverse --height=70%)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line
  BUFFER="builtin cd -- ${(q)dir:a}"
  zle accept-line
  local ret=$?
  unset dir
  zle reset-prompt
  return $ret
}

zle -N cd-widget-normal
bindkey '\ec' cd-widget-normal
bindkey -M emacs '\ec' cd-widget-normal
bindkey -M vicmd '\ec' cd-widget-normal
bindkey -M viins '\ec' cd-widget-normal

cd-widget-hidden() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(fd -H -t d | fzf --reverse --height=70%)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line
  BUFFER="builtin cd -- ${(q)dir:a}"
  zle accept-line
  local ret=$?
  unset dir
  zle reset-prompt
  return $ret
}

zle -N cd-widget-hidden
bindkey '\eh' cd-widget-hidden
bindkey -M emacs '\eh' cd-widget-hidden
bindkey -M vicmd '\eh' cd-widget-hidden
bindkey -M viins '\eh' cd-widget-hidden


alias ls="eza --icons=always"
alias la="eza -a --icons=always"
alias ll="eza -al --icons=always"
alias lt="eza -a --tree --icons=always"
# alias cleanup="sudo pacman -Rsn `(pacman -Qtdq)`"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/holubpat/.opam/opam-init/init.zsh' ]] || source '/home/holubpat/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

[ -f "/home/holubpat/.ghcup/env" ] && . "/home/holubpat/.ghcup/env" # ghcup-env

export PHP_CS_FIXER_IGNORE_ENV=1

# Created by `pipx` on 2025-04-24 15:30:38
export PATH="$PATH:/home/holubpat/.local/bin"

# bat coloring for manpages
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

ncd-normal() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  while :; do
    local cd_path=$( (echo ".."; fd -t d -d 1) | \
           fzf --reverse --height=40% --border --prompt="> " \
               --preview='eza -l --git --icons --color=always {}' )

    if [ -z "$cd_path" ]; then
      zle push-line
      zle accept-line
      unset cd_path
      zle reset-prompt

      return 0
    fi

    builtin cd -- ${(q)cd_path:a} || return 1
  done
}

zle -N ncd-normal
bindkey '^n' ncd-normal
bindkey -M emacs '^n' ncd-normal
bindkey -M vicmd '^n' ncd-normal
bindkey -M viins '^n' ncd-normal

ncd-hidden() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  while :; do
    local cd_path=$( (echo ".."; fd -H -t d -d 1) | \
           fzf --reverse --height=40% --border --prompt="> " \
               --preview='eza -a -l --git --icons --color=always {}' )

    if [ -z "$cd_path" ]; then
      zle push-line
      zle accept-line
      unset cd_path
      zle reset-prompt

      return 0
    fi

    builtin cd -- ${(q)cd_path:a} || return 1
  done
}

zle -N ncd-hidden
bindkey '^h' cd-hidden
bindkey -M emacs '^h' cd-hidden
bindkey -M vicmd '^h' cd-hidden
bindkey -M viins '^h' cd-hidden

# Source prompt configuration
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# set the configured theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

# This needs to stay at the end
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
