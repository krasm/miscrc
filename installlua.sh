#!/bin/sh
# -*- mode: sh -*-

rm -rf /tmp/lua
mkdir /tmp/lua
cd /tmp/lua
curl -R -O http://www.lua.org/ftp/lua-5.4.1.tar.gz
tar zxf lua-5.4.1.tar.gz
cd lua-5.4.1
make all test

RC=$?
if [ "x$RC" = "x0" ]; then
    cp /tmp/lua/lua-5.4.1/src/lua $HOME/bin
    cp /tmp/lua/lua-5.4.1/src/luac $HOME/bin
fi
