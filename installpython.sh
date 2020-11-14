#!/bin/sh
# -*- mode: sh -*-

PYTHON_VER=3.9.0
PYTHON_SRC=Python-$PYTHON_VER
PYTHON_DIST=$HOME/opt/python3

sudo apt update && sudo apt upgrade
#sudo apt install -y zlib1g-dev libbz2-dev libssl-dev ncurses-dev libsqlite3-dev libreadline-dev tk-dev libgdbm-dev libdb4-dev libpcap-dev libxz-dev libexpat-dev
sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev

curl -O https://www.python.org/ftp/python/$PYTHON_VER/$PYTHON_SRC.tar.xz

tar xf $PYTHON_SRC.tar.xz

mkdir -p $HOME/opt/python3
cd $PYTHON_SRC

RC=$?
if [ "x"$RC = "x0" ]; then
    ./configure --prefix=$PYTHON_DIST --enable-optimizations --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath $PYTHON_DIST"
else
    echo "failed to configure python [$RC]"
    exit 1
fi

RC=$?
if [ "x"$RC = "x0" ]; then
    make
else
    echo "failed to build [$RC]"
    exit 1
fi

RC=$?
if [ "x"$RC = "x0" ]; then
    make altinstall
else
    echo "failed to install [$RC]"
    exit 1
fi

echo "updating .profile"
echo "PATH=$PYTHON_DIST/bin:\$PATH" >> ~/.profile
echo "LD_LIBRARY_PATH=.:$PYTHON_DIST/lib:\$LD_LIBRARY_PATH" >> ~/.profile

export PATH
export LD_LIBRARY_PATH
