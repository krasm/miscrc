#!/bin/sh 

PACKAGES="tmux neomutt msmtp pass manpages manpages-dev man groff mpd mpc upower mc taskwarrior w3m" 

install_package() {
    echo "installing $1"
    sudo apt install -y --fix-missing $1
}

#create soft link from 1 to 2
link() {
    SRC=$PWD/$1 
    DST=$HOME/$2
    if [ -f $SRC ]; then 
	if [ -L $DST ]; then 
		rm $DST
	fi
	if [ -f $DST ]; then 
		mv $DST $DST.save
	fi
        echo "setting $1"
        ln -s $SRC $DST
    fi
}


sudo apt update && sudo apt upgrade -y

for i in `echo $PACKAGES | cut -d ' ' -f 1-` ; do 
    install_package $i
done

link "_Xresources" ".Xresources"
link "_bash_profile" ".profile"
link "_tmuxrc" ".tmux.conf"
link "_vimrc" ".vimrc"
link "_xsession" ".xsession"
link "_muttrc" ".muttrc"

if [ -f $HOME/".bash_profile" ] ; then 
    echo ". $HOME/.profile " >> $HOME/.bash_profile
fi

#/bin/sh ./viminst.sh

curl -s get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
