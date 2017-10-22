
export DOTFILES=$HOME/.dotfiles
[[ ":$PATH:" != *":${DOTFILES}/bin:"* ]] && PATH="${DOTFILES}/bin:${PATH}"
[[ ":$PATH:" != *":${HOME}/bin:"* ]] && PATH="${HOME}/bin:${PATH}"

source $DOTFILES/colors.sh
source $DOTFILES/bash/git-completion.sh
source $DOTFILES/bash/prompt.sh
source $DOTFILES/exports.sh
source $DOTFILES/aliases.sh
