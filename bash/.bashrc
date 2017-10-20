
export DOTFILES=$HOME/.dotfiles
[[ ":$PATH:" != *":${DOTFILES}/bin:"* ]] && PATH="${DOTFILES}/bin:${PATH}"
[[ ":$PATH:" != *":${HOME}/bin:"* ]] && PATH="${HOME}/bin:${PATH}"

source $DOTFILES/bash/git-completion
source $DOTFILES/bash/prompt
source $DOTFILES/exports
source $DOTFILES/aliases
