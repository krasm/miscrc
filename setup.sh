#!/bin/bash 

ITEM=`pwd`"/_Xresources"
if [ -f $ITEM ]; then 
	echo "setting $ITEM"\
	ln -s $ITEM $HOME/.Xresources
fi

ITEM=`pwd`"/_bash_profile" 
if [ -f $ITEM ]; then
	echo "setting $ITEM"
	ln -s $ITEM $HOME/.profile
fi

ITEM=`pwd`"/_tmuxrc"
if [ -f $ITEM ]; then 
	echo "setting $ITEM"
	ln -s $ITEM $HOME/.tmux.conf
fi

ITEM=`pwd`"/_vimrc" 
if [ -f $ITEM ]; then
	echo "installing $ITEM"
	ln -s $ITEM $HOME/.vimrc
fi

ITEM=`pwd`"/_xsession"
if [ -f $ITEM ]; then
	echo "installing $ITEM"
	ln -s $ITEM $HOME/.xsessionrc
fi

if [ ! -d $HOME"/.config/openbox" ]; then 
	mkdir -p $HOME"/.config/openbox"
fi


