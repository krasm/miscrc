#!/bin/sh

IDX=2

for i in `ls $HOME/.mutt/*.settings.gpg` ; do 
    echo "macro index <f$IDX> '<sync-mailbox><enter-command>source \"gpg -d $i |\"<enter><change-folder>!<enter>'"
    IDX=$((IDX + 1))
done
