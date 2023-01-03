
parse_git_dirty() {
  if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
    echo -n "*"
  fi
}

parse_git_rebase_branch() {
  local root=$(git rev-parse --show-toplevel 2> /dev/null)
  if [[ -z $root ]]; then
    return
  fi
  
  cat "$root/.git/rebase-apply/head-name" 2> /dev/null \
      || cat "$root/.git/rebase-merge/head-name" 2> /dev/null \
      | sed -e 's/refs\/heads\///'
}

parse_git_rebase_onto() {
  local root=$(git rev-parse --show-toplevel 2> /dev/null)
  if [[ -z $root ]]; then
    return
  fi

  local onto=$(cat "$root/.git/rebase-apply/onto" 2> /dev/null || cat "$root/.git/rebase-merge/onto" 2> /dev/null)
  if [[ ! -z "$onto" ]]; then
    local onto_name=$(git branch -a --contains $onto | tail -n1 | tr -d ' ' | sed -e 's/remotes\///')
    if [[ ! -z "$onto_name" ]]; then
      echo -n $onto_name
    else
      echo -n ${onto:0:7}
    fi
  fi
}

parse_git_merge() {
  local root=$(git rev-parse --show-toplevel 2> /dev/null)
  if [[ -z $root ]]; then
    return
  fi

  local merge=$(cat "$root/.git/MERGE_HEAD" 2> /dev/null)
  if [[ ! -z "$merge" ]]; then
    local merge_name=$(git branch -a --contains $merge | tail -n1 | tr -d ' ' | sed -e 's/remotes\///')
    if [[ ! -z "$merge_name" ]]; then
      echo -n $merge_name
    else
      echo -n ${merge:0:7}
    fi
  fi
}

format_git_branch() {
    sed -e 's/\([a-z]\).*\/[0-9]\{2\}\([0-9]\{4\}\)\/\(.*\)/\1\/\2\/\3/' -e 's/\(.*\)/\1/'
}

parse_git_branch() {
  local dirty="" # $(parse_git_dirty)
  local root=$(git rev-parse --show-toplevel 2> /dev/null)
  local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  local rebase=$(parse_git_rebase_onto)
  local merge=$(parse_git_merge)

  if [[ ! -z $rebase ]]; then
    branch=$(parse_git_rebase_branch)
  fi

  if [[ ! -z $branch ]]; then
    echo -n "("
    if [[ ! -z $merge ]]; then
        echo -n $merge | format_git_branch
        echo -n " -> "
    fi

    echo -n $branch | format_git_branch
    echo -n "$dirty"

    if [[ ! -z $rebase ]]; then
      echo -n " => "
      echo -n $rebase | format_git_branch
    fi
    echo -n ")"
  fi
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

set_prompt() {
  PS1="\[${blue}\]$(parse_dir)\[${yellow}\]$(parse_git_branch)\[${normal}\]» "
}

export PROMPT_COMMAND=set_prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
