# git
alias gitlog='git log --format="%C(yellow)%h %Cblue%an %Creset%s"'
alias gits='git status'

# ls
alias ls='ls -alh'

# ag
alias ag='ag -p $DOTFILES/ag/.ignore'
alias rg="rg -g '!.git/'"

alias sed='gsed'

function agr() {
    ag -0 -l "$1" | AGR_FROM="$1" AGR_TO="$2" xargs -0 perl -pi -e 's/$ENV{AGR_FROM}/$ENV{AGR_TO}/g';
}

lg () {
  ~/go/bin/lg "$@" | awk '{ printf "\033[1;34m" $1 "\033[0m"; $1="\t"; print $0; }' |
  fzf --border --multi --ansi --height=70%  \
      --delimiter='\t' \
      --preview='echo -e {2}' \
      --preview-window=top:wrap
}
