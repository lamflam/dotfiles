export GPG_TTY=$(tty)

if [ -e $DOTFILES/exports.local.sh ]; then
  source $DOTFILES/exports.local.sh
fi
