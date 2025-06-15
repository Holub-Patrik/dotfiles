# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch menu_complete
unsetopt autocd beep notify auto_list list_ambiguous 
bindkey -e
fpath+=($HOME/.zsh/pure)

zstyle :compinstall filename '/home/holubpat/.zshrc'
autoload -Uz compinit
compinit

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

zstyle ':completion:*' menu select=-1
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
source <(fzf --zsh)

# the fuck ?
eval "$(thefuck --alias fuck)"

alias ls="eza --icons=always"
alias la="eza -a --icons=always"
alias ll="eza -al --icons=always"
alias lt="eza -a --tree --icons=always"
alias cleanup="sudo pacman -Rsn `(pacman -Qtdq)`"


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

# Source prompt configuration
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# set the configured theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

# This needs to stay at the end
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
