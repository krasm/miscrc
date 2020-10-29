#!/bin/sh

PYTHON_VER=3.7.3
PYTHON_SRC=Python-$PYTHON_VER
PYTHON_DIST=/home/krasm/opt/python3

sudo apt update && sudo apt upgrade
sudo apt install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel expat-devel

curl -O https://www.python.org/ftp/python/$PYTHON_VER/$PYTHON_SRC.tar.xz

tar xf $PYTHON_SRC.tar.xz

mkdir $HOME/opt/python3
(cd $PYTHON_SRC && ./configure --prefix=$PYTHON_DIST --enable-optimizations --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath $PYTHON_DIST" && make && make altinstall)
