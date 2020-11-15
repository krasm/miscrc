#!/bin/sh

EMACS_VERSION=27.1


if [ -d /tmp/emacs ]; then
    rm -rf /tmp/emacs
fi

git clone --depth=1 -b emacs-$EMACS_VERSION  https://github.com/emacs-mirror/emacs.git  /tmp/emacs

cd /tmp/emacs

autogen.sh && ./configure --with-xml2 --with-zlib --without-x --without-sound --without-xpm \
	    --without-jpeg --without-tiff --without-gif --without-png --without-rsvg \
	    --without-imagemagick --with-xft --with-libotf --without-m17n-flt \
	    --without-xaw3d --without-toolkit-scroll-bars --without-gpm --without-dbus \
            --without-gconf --without-gsettings --without-makeinfo \
            --without-compress-install --without-x --prefix=$HOME/opt/emacs-$EMACS_VERSION

RC=$?

echo "configure returned $RC"

mkdir $HOME/opt

if [ $RC = "0" ]; then
    make && make install
else
    echo "failed to configure"
fi

ln -s $HOME/emacs-$EMACS_VERSION/bin/emacs $HOME/opt/bin


mkdir -p $HOME/prj
mkdir -p $HOME.emacs.d

if [ -d $HOME/prj/emacsrc ] ; then
    cd $HOME/prj/emacsrc
    git pull
else
    git clone https://github.com/krasm/emacsrc.git $HOME/prj/emacsrc
fi

ln -s $HOME/prj/emacsrc/init.el $HOME/.emacs.d/init.el
