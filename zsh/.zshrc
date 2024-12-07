HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch menu_complete
unsetopt autocd beep notify auto_list list_ambiguous 
bindkey -e

zstyle :compinstall filename '/home/holubpat/.zshrc'
autoload -Uz compinit
compinit

source $HOME/.antigen.zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
# antigen bundle heroku
# antigen bundle pip
# antigen bundle lein
# antigen bundle command-not-found
antigen bundle ssh-agent

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

zstyle ':completion:*' menu select=-1
bindkey '^[[Z' reverse-menu-complete

# [ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" &>/dev/null

# add the odin binary
export PATH="$PATH:$HOME/Odin"
export GIT_EDITOR="nvim"

# starship command prompt
prompt off
eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# the fuck ?
eval "$(thefuck --alias fuck)"

alias ls="eza --icons"
alias la="eza -a --icons"
alias ll="eza -al --icons"
alias lt="eza -a --tree --level=1 --icons"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/holubpat/.opam/opam-init/init.zsh' ]] || source '/home/holubpat/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
