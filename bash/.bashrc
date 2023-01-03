set -o vi
export EDITOR=vim
export VISUAL=vim
export DOTFILES=$HOME/.dotfiles

add_to_path() {
    [[ ":$PATH:" != *":${1}:"* ]] && PATH="${1}:${PATH}"
}

add_to_path "${DOTFILES}/bin"
add_to_path "${HOME}/bin"
add_to_path "${HOME}/.local/bin"

source $DOTFILES/bash/colors.sh
source $DOTFILES/bash/aliases.sh
source $DOTFILES/bash/prompt.sh
source $DOTFILES/bash/exports.sh
source $DOTFILES/fzf/setup.sh

if [ -e $DOTFILES/bash/.localrc ]; then
    source $DOTFILES/bash/.localrc
fi
