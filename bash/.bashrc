
export DOTFILES=$HOME/.dotfiles
[[ ":$PATH:" != *":${DOTFILES}/bin:"* ]] && PATH="${DOTFILES}/bin:${PATH}"
[[ ":$PATH:" != *":${HOME}/bin:"* ]] && PATH="${HOME}/bin:${PATH}"
[[ ":$PATH:" != *":${HOME}/.local/bin:"* ]] && PATH="${HOME}/.local/bin:${PATH}"

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
source $DOTFILES/bash/prompt.sh
source $DOTFILES/exports.sh
source $DOTFILES/aliases.sh
source $DOTFILES/fzf_setup.sh
