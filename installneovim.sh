#!/bin/sh

VERSION=0.10.4

(cd $HOME/tmp && git clone https://github.com/neovim/neovim)
(cd $HOME/tmp && git checkout tags/v$VERSION)
(cd $HOME/tmp/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/opt/neovim-$VERSION install)
