export DOTFILES=$HOME/.dotfiles

add_to_path() {
    [[ ":$PATH:" != *":${1}:"* ]] && PATH="${1}:${PATH}"
}

add_to_path "${DOTFILES}/bin"
add_to_path "${HOME}/bin"
add_to_path "${HOME}/.local/bin"

# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.bash ]; then
  source /usr/local/opt/fzf/shell/key-bindings.bash
  source /usr/local/opt/fzf/shell/completion.bash
fi

# fzf via local installation
if [ -e ~/.fzf ]; then
  _append_to_path ~/.fzf/bin
  source ~/.fzf/shell/key-bindings.bash
  source ~/.fzf/shell/completion.bash
fi

source $DOTFILES/colors.sh
source $DOTFILES/bash/git-completion.sh
source $DOTFILES/aliases.sh
source $DOTFILES/bash/prompt.sh
source $DOTFILES/exports.sh
source $DOTFILES/fzf_setup.sh

if [ -e $DOTFILES/bash/.localrc ]; then
    source $DOTFILES/bash/.localrc
fi
