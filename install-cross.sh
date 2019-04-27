#!/bin/bash

if [[ ! -f /etc/centos-release ]]; then
    cat /etc/os-release | head -2
    echo "ERROR: CentOS Linux is required"
    exit 1
fi

if [[ $# -ne 1 ]]; then
    echo "ERROR: invalid argument"
    echo "./install-cross.sh glnx64|win64|win32"
    exit 1
fi

rm -rf $1

if [[ -f Makefile ]]; then
    make distclean
fi

if [[ $1 = "glnx64" ]]; then

    qmake-qt4 src || exit 1
    make || exit 1

    # sudo apt install libqtgui4
    # sudo yum install qt-x11
    mkdir $1
    cp rtm-gwas-gui $1/
    strip -s $1/rtm-gwas-gui

elif [[ $1 = "win32" ]]; then

    mingw32-qmake-qt4 "CONFIG += static" src || exit 1
    make release || exit 1

    mkdir $1
    cp release/rtm-gwas-gui.exe $1/
    mingw-strip -s $1/rtm-gwas-gui.exe

elif [[ $1 = "win64" ]]; then

    mingw64-qmake-qt4 "CONFIG += static" src || exit 1
    make release || exit 1

    mkdir $1
    cp release/rtm-gwas-gui.exe $1/
    mingw-strip -s $1/rtm-gwas-gui.exe

else

    echo "ERROR: invalid argument: $1"
    echo "./install-cross.sh glnx64|win64|win32"
    exit 1

fi
