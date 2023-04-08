#!/bin/sh

machine=`uname -s`
LINKS="yes"

case $machine in
    "CYGWIN_NT"* )
        echo "on cygwin you need to install packages manually"
        LINKS="no"
        ;;
    * )
        if command -v apt &> /dev/null
        then
            sudo apt update -y &&  sudo apt upgrade -y
            sudo apt install -y python3-flake8 vim-nox curl git
        fi
    ;;
esac

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
    sudo apt install -y python3-flake8 vim-nox curl git neovim python3-neovim python3-dev python3-pynvim python3-pip  taskwarrior
    check_error $?
    sudo apt install checkstyle
    check_error $?
    sudo apt install protobuf npm
fi

echo "installing flake8"
python3 -m pip install flake8 tasklib


echo "building neovim"
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
mkdir /tmp/neovim
git clone https://github.com/neovim/neovim.git /tmp/neovim
cd /tmp/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/opt/neovim && make install


create_dir ".vim/autoload"
create_dir ".vim/bundle"

vim +helptags +qall
nvim +helptags +qall

if [ "x"$LINKS != "yes" ]; then
    ln -s $PWD/_vimrc  $HOME/.vimrc
else
    cp _vimrc $HOME/.vimrc
fi
