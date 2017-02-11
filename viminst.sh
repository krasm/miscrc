#!/bin/sh

if [ ! -f $HOME/.vim/autoload ] ; then 
    mkdir -p $HOME/.vim/autoload 
fi

if [ ! -f $HOME/.vim/bundle ] ; then 
    mkdir -p $HOME/.vim/bundle
fi

echo "getting pathogen"
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


if [ ! -d $HOME/.vim/bundle/vim-sensible ] ; then 
    echo "getting sensible"
    git clone https://github.com/tpope/vim-sensible.git $HOME/.vim/bundle/vim-sensible
else 
    echo "updating vim sensible"
    (cd $HOME/.vim/bundle/vim-sensible && git pull)
fi

echo "getting dependencies for you complete me"
sudo apt-get install -y build-essential cmake python-dev python3-dev golang nodejs npm

if [ ! -f /usr/bin/node ] ; then
    sudo ln -s /usr/bin/nodejs /usr/bin/node
fi

if [ -d $HOME/.vim/bundle/YouCompleteMe ] ; then 
    echo "updating you complete me"
    (cd $HOME/.vim/bundle/YouCompleteMe && git pull)
    (cd $HOME/.vim/bundle/YouCompleteMe && git submodule update --recursive && ./install.py --clang-completer --gocode-completer --tern-completer)
else 
    echo "cloning you complete me"
    git clone https://github.com/Valloric/YouCompleteMe.git  $HOME/.vim/bundle/YouCompleteMe
    (cd $HOME/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && ./install.py --clang-completer --gocode-completer --tern-completer)
fi


if [ -d $HOME/.vim/bundle/powerline ] ; then 
    (cd $HOME/.vim/bundle/powerline && git pull)
else
    echo "clonning powerline"
    git clone git://github.com/Lokaltog/vim-powerline.git $HOME/.vim/bundle/powerline
fi

if [ -d $HOME/.vim/bundle/python-mode ] ; then 
    (cd $HOME/.vim/bundle/python-mode && git pull)
else
    echo "clonning python mode"
    git clone https://github.com/klen/python-mode.git $HOME/.vim/bundle/python-mode
fi
