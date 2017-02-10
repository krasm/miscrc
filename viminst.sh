#!/bin/sh

if [ ! -f $HOME/.vim/autoload ] ; then 
    mkdir -p $HOME/.vim/autoload 
fi

if [ ! -f $HOME/.vim/bundle ] ; then 
    mkdir -p $HOME/.vim/bundle
fi

echo "getting pathogen"
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "getting sensible"
git clone https://github.com/tpope/vim-sensible.git $HOME/.vim/bundle/vim-sensible

echo "getting dependencies for you complete me"
sudo apt-get install -y build-essential cmake python-dev python3-dev golang nodejs npm

if [ ! -f /usr/bin/node ] ; then
    sudo ln -s /usr/bin/nodejs /usr/bin/node
fi

echo "cloning you complete me"
git clone https://github.com/Valloric/YouCompleteMe.git  $HOME/.vim/bundle/YouCompleteMe

(cd $HOME/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && ./install.py --clang-completer --gocode-completer --tern-completer)
