
export DOTFILES=$HOME/.dotfiles
[[ ":$PATH:" != *":${DOTFILES}/bin:"* ]] && PATH="${DOTFILES}/bin:${PATH}"
[[ ":$PATH:" != *":${HOME}/bin:"* ]] && PATH="${HOME}/bin:${PATH}"

source $DOTFILES/colors.sh
source $DOTFILES/bash/git-completion.sh
source $DOTFILES/bash/prompt.sh
source $DOTFILES/exports.sh
source $DOTFILES/aliases.sh

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

# fzf + ag configuration
if type fzf >/dev/null 2>&1 && type ag >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='ag --hidden --nocolor -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='
  --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  '
fi
