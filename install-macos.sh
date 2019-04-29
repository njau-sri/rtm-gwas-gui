#!/bin/bash

export PATH="/usr/local/opt/qt/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/qt/lib"
export CPPFLAGS="-I/usr/local/opt/qt/include"

rm -rf macos
mkdir macos

make distclean

qmake src
make

macdeployqt rtm-gwas-gui.app
mv rtm-gwas-gui.app macos/
