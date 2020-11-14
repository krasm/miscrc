#!/bin/sh
-*- mode: sh -*-

link() {
    SRC=$PWD/$1
    DST=$HOME/$2

    if [ -z $DST ]; then
	rm $DST
    fi

    if [ -f $DST ]; then
	echo "$DST exists. skipping"
    elif [ -f $SRC ]; then
	echo "linking $SRC to $DST"
	ln -s $SRC $DST
    fi
}

link "_Xresources" ".Xresources"
link "_xsession" ".xsessionrc"
link "_bash_profile" ".profile"
link "_tmuxrc" ".local/config/.tmux.conf"
link "_vimrc" ".vimrc"

/bin/sh -f installvim.sh
/bin/sh -f installemacs.sh
/bin/sh -f installpython.sh
