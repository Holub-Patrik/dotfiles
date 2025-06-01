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

# set prompt to pure => turn off starship
# autoload -U promptinit; promptinit
# prompt pure

source $HOME/.antigen.zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
# antigen bundle heroku
# antigen bundle pip
# antigen bundle lein
# antigen bundle command-not-found
antigen bundle ssh-agent
antigen theme romkatv/powerlevel10k

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

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

# starship command prompt
# if type "prompt" > /dev/null ; then
# 	prompt off
# fi
# eval "$(starship init zsh)"

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

export PHP_CS_FIXER_IGNORE_ENV=true

# Created by `pipx` on 2025-04-24 15:30:38
export PATH="$PATH:/home/holubpat/.local/bin"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
