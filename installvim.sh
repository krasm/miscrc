#!/bin/sh

if command -v apt &> /dev/null
then
    sudo apt update -y &&  sudo apt upgrade -y
    sudo apt install -y pylint3 python3-flake8
fi


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

echo "installing flake8"
python -m pip install flake8

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

vim +helptags +qall

ln -s $PWD/_vimrc  $HOME/.vimrc

