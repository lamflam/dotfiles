
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}

parse_git_branch() {
  local dirty=$(parse_git_dirty)
  git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/\([a-z]\).*\/[0-9]\{2\}\([0-9]\{4\}\)\/\(.*\)/\1\/\2\/\3/' -e 's/\(.*\)/(\1'"$dirty"')/'
}

parse_dir() {
  if [ -z "$VIRTUAL_ENV" ]; then
    pwd | sed 's|'"$HOME"'\(.*\)|~\1|'
  else
    VENV_DIR=$(dirname "$VIRTUAL_ENV")
    VENV=$(basename $VENV_DIR)
    pwd | sed -e 's|'"$VENV_DIR"'\(.*\)|'"$VENV"'\1|' -e 's|'"$HOME"'\(.*\)|~\1|' -e 's|\(.*\)|[\1]|'
  fi
}

function boldtext {
    echo "\\[\\033[1m\\]"$1"\\[\\033[0m\\]"
}

function bgcolor {
    echo "\\[\\033[48;5;"$1"m\\]"
}

function fgcolor {
    echo "\\[\\033[38;5;"$1"m\\]"
}

function resetcolor {
    echo "\\[\\e[0m\\]"
}

export PS1="$(fgcolor 033)$(boldtext $'$(parse_dir)')$(fgcolor 184) $(boldtext $'$(parse_git_branch)')$(resetcolor)🥃  "
export VIRTUAL_ENV_DISABLE_PROMPT=1
