#!/bin/sh

VIM_CURRENT_TAG=v8.2.1955
VIM_DEST_DIR=$HOME/opt/vim$VIM_CURRENT_TAG
NEOVIM_DEST_DIR=$HOME/opt/neovim

sudo apt update 
sudo apt upgrade 
sudo apt install -y curl git libncurses-dev ncurses-doc ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

echo "Building vim"
git clone --depth 1 --branch $VIM_CURRENT_TAG https://github.com/vim/vim.git __vimbuild
(cd __vimbuild && ./configure --prefix=$VIM_DEST_DIR --enable-cscope --enable-luainterp=yes --enable-python3interp=yes --enable-multibyte && make && make install && rm -r __vimbuild)

echo "Building neovim" 
git clone https://github.com/neovim/neovim.git __neovimbuild
(cd __neovimbuild && git checkout stable && make CMAKE_INSTALL_PREFIX=$NEOVIM_DEST_DIR && make install )

mkdir -p $HOME/bin
for f in `ls $VIM_DEST_DIR/bin` ; do 
    ln -s $VIM_DEST_DIR/bin/$f $HOME/bin
done
for f in `ls $NEOVIM_DEST_DIR/bin` ; do 
    ln -s $NEOVIM_DEST_DIR/bin/$f $HOME/bin
done

mkdir -p $HOME/.config/nvim/
ln -s $PWD/nvim/init.vim $HOME/.config/nvim/init.vim

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
sudo apt install -y build-essential cmake python3-dev golang nodejs libnode-dev npm 

if [ -d $HOME/.vim/bundle/YouCompleteMe ] ; then 
    echo "updating you complete me"
    (cd $HOME/.vim/bundle/YouCompleteMe && git pull)
    (cd $HOME/.vim/bundle/YouCompleteMe && git submodule update --recursive && ./install.py  --gocode-completer --java-completer --tern-completer --clang-completer --js-completer)
else 
    echo "cloning you complete me"
    git clone https://github.com/Valloric/YouCompleteMe.git  $HOME/.vim/bundle/YouCompleteMe
    (cd $HOME/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && ./install.py --clang-completer --java-completer --tern-completer --gocode-completer --js-completer)
fi

if [ -d $HOME/.vim/bundle/powerline ] ; then 
    (cd $HOME/.vim/bundle/powerline && git pull)
else
    echo "clonning powerline"
    git clone git://github.com/Lokaltog/vim-powerline.git $HOME/.vim/bundle/powerline
fi

#sudo yum install -y python2-rope python34-rope 
sudo apt install -y python-pip python-rope  
sudo pip install ropevim

if [ -d $HOME/.vim/bundle/ropevim ] ; then
    (cd $HOME/.vim/bundle/ropevim && git pull)
else
    echo "clonning ropevim"
    git clone https://github.com/python-rope/ropevim.git $HOME/.vim/bundle/ropevim
fi

if [ -d $HOME/.vim/bundle/python-mode ] ; then 
    (cd $HOME/.vim/bundle/python-mode && git pull && git submodule update --init --recursive)
else
    echo "clonning python mode"
    git clone --recurse-submodule https://github.com/klen/python-mode.git $HOME/.vim/bundle/python-mode
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

if [ ! -d $HOME/.vim/bundle/vim-colors-solarized ] ; then 
    echo "getting solarized"
    git clone git://github.com/altercation/vim-colors-solarized.git $HOME/.vim/bundle/vim-colors-solarized
else
    echo "updating solarized"
    (cd $HOME/.vim/bundle/vim-colors-solarized && git pull)
fi

