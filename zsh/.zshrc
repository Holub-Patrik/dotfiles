HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch menu_complete
unsetopt autocd beep notify auto_list list_ambiguous 
bindkey -v

zstyle :compinstall filename '/home/holubpat/.zshrc'
autoload -Uz compinit
compinit

source $HOME/.antigen.zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

zstyle ':completion:*' menu select=-1
bindkey '^[[Z' reverse-menu-complete

[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" &>/dev/null

# add the odin binary
export PATH="$PATH:$HOME/Odin"

# starship command prompt
prompt off
eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# the fuck ?
eval "$(thefuck --alias fuck)"

alias ls="eza --icons=always"
