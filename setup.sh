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

install_brew() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install_kr() {
    curl https://krypt.co/kr | sh
}

install_tmux() {
    brew install tmux
}

install_fzf() {
    brew install fzf
}

install_ag() {
    brew install ag
}

install_node() {
    brew install node
    npm install -g n
    npm install -g yarn
}

install_cmake() {
    brew install cmake
}

install_reattach-to-user-namespace() {
    brew install reattach-to-user-namespace
}

install_gsed() {
    brew install gnu-sed
}

install_link $DOTFILES_GIT_DIR $DOTFILES
install_link $DOTFILES/bash/.bashrc $HOME/.bashrc
install_link $DOTFILES/bash/.bash_profile $HOME/.bash_profile
install_link $DOTFILES/vim/.vim $HOME/.vim
install_link $DOTFILES/vim/.vimrc $HOME/.vimrc
install_link $DOTFILES/tmux/.tmux.conf $HOME/.tmux.conf
install_link $DOTFILES/tern/.tern-config $HOME/.tern-config
install_link $DOTFILES/git/config $HOME/.customgitconfig


install_command brew
install_command kr
install_command tmux
install_command fzf
install_command ag
install_command node
install_command cmake
install_command reattach-to-user-namespace
install_command gsed

vim +PluginInstall +qall

if [ ! -e $DOTFILES/.ycm_installed ]; then
    pushd ~/.vim/bundle/YouCompleteMe > /dev/null
    ./install.py --clang-completer --js-completer && touch $DOTFILES/.ycm_installed
    popd > /dev/null
else
    echo "YouCompleteMe already built"
fi

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
