#!/bin/sh


create_dir() {
    DST=$HOME/$1
    echo "creating $DST"
    if [ ! -f $DST ] ; then
	mkdir -p $DST
    fi
}

install_package() {
    PKGNAME=$1
    PKGSRC=$2
    DSTDIR="$HOME/.vim/bundle/$1"

    echo "installing $1"
    if [ ! -d $DSTDIR ] ; then
        git clone $PKGSRC $DSTDIR
    else
        (cd $DSTDIR && git pull)
    fi
}

check_error() {
    RESULT=$?
    if [ $RESULT != 0 ]; then
        echo "failed to execute - quitting"
        exit 1
    fi
}

echo "installing system dependencies"
if command -v apt &> /dev/null
then
    sudo apt update -y &&  sudo apt upgrade -y
    sudo apt install -y pylint3 python3-flake8 vim-nox curl git neovim python3-neovim python3-dev python3-pynvim python3-pip  taskwarrior
    check_error $?
    sudo apt install checkstyle
    check_error $?
    sudo apt install protobuf npm
fi

echo "installing flake8"
python3 -m pip install flake8 tasklib

echo "building java language server"
# java 13

# java home

#build


echo "building neovim"
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
mkdir /tmp/neovim
git clone https://github.com/neovim/neovim.git /tmp/neovim
cd /tmp/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/opt/neovim && make install


create_dir ".vim/autoload"
create_dir ".vim/bundle"

echo "getting pathogen"
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


install_package "vim-sensible" "https://github.com/tpope/vim-sensible.git"
install_package "vim-commentary" "https://tpope.io/vim/commentary.git"
install_package "vim-ale" "https://github.com/dense-analysis/ale.git"
install_package "vim-fugitive" "https://github.com/tpope/vim-fugitive.git"
install_package "vim-colors-solarized"  "git://github.com/altercation/vim-colors-solarized.git"
install_package "nerdtree" "https://github.com/scrooloose/nerdtree.git"
install_package "airline" "https://github.com/vim-airline/vim-airline"
install_package "python-mode" "https://github.com/klen/python-mode.git"
install_package "vimwiki" "https://github.com/vimwiki/vimwiki.git"
install_package "taskwiki" "https://github.com/tools-life/taskwiki"
install_package "kotlin-vim" "https://github.com/udalov/kotlin-vim"
install_package "vim-go" "https://github.com/fatih/vim-go.git"

vim +helptags +qall
nvim +helptags +qall

ln -s $PWD/_vimrc  $HOME/.vimrc

