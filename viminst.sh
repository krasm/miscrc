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
sudo dnf install -y typescript

if [ -d $HOME/.vim/bundle/YouCompleteMe ] ; then 
    echo "updating you complete me"
    (cd $HOME/.vim/bundle/YouCompleteMe && git pull)
    (cd $HOME/.vim/bundle/YouCompleteMe && git submodule update --recursive && ./install.py  --gocode-completer --java-completer)
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

sudo pip3 install ropevim
if [ -d $HOME/.vim/bundle/ropevim ] ; then
    (cd $HOME/.vim/bundle/ropevim && git pull)
else
    echo "clonning ropevim"
    git clone https://github.com/python-rope/ropevim.git $HOME/.vim/bundle/ropevim
fi

if [ -d $HOME/.vim/bundle/python-mode ] ; then 
    (cd $HOME/.vim/bundle/python-mode && git pull)
else
    echo "clonning python mode"
    git clone https://github.com/klen/python-mode.git $HOME/.vim/bundle/python-mode
fi

if [ -d $HOME/.vim/bundle/nerdtree ] ; then
    (cd $HOME/.vim/bundle/nerdtree && git pull)
else
    echo "clonning nerd tree"
    git clone https://github.com/scrooloose/nerdtree.git $HOME/.vim/bundle/nerdtree
fi

# vim -u NONE -c "helptags vim-fugitive/doc" -c q
if [ ! -d $HOME/.vim/bundle/vim-fugitive ] ; then 
    echo "getting fugitive"
    git clone https://github.com/tpope/vim-fugitive.git $HOME/.vim/bundle/vim-fugitive
else 
    echo "updating vim fugitive"
    (cd $HOME/.vim/bundle/vim-fugitive && git pull)
fi

