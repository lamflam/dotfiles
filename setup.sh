# Get current directory for creating symlinks
DOTFILES_GIT_DIR=$(git rev-parse --show-toplevel)
DOTFILES=$HOME/.dotfiles

install_link() {
    if [ ! -e "$2" ]; then
        echo "linking ${2} > ${1}"
        ln -s "$1" "$2"
    else
        echo "${2} already exists"
    fi
}

command_exists() {
    command -v "$1"
}

install_command() {
    if [ $(command_exists "$1") ]; then
        echo "${1} already installed"
    else
        echo "Installing ${1}"
        eval "install_${1}"
    fi
}

install_link $DOTFILES_GIT_DIR $DOTFILES
install_link $DOTFILES/bash/.bashrc $HOME/.bashrc_local
install_link $DOTFILES/bash/.bash_profile $HOME/.bash_profile_local
install_link $DOTFILES/vim/.vim $HOME/.vim
install_link $DOTFILES/vim/.vimrc $HOME/.vimrc
install_link $DOTFILES/tmux/.tmux.conf $HOME/.tmux.conf
install_link $DOTFILES/idea/ideavimrc $HOME/.ideavimrc

git config --global include.path "$DOTFILES/git/config"

if [ ! -e $DOTFILES/.fonts_installed ]; then
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
    touch $DOTFILES/.fonts_installed
else
    echo "Fonts already installed"
fi
