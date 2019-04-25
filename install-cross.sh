#!/bin/bash

rm -rf $1
mkdir $1

make distclean

if [ $1 == "glnx64" ]; then

	/opt/qt4-static/bin/qmake
    make

    strip -s rtm-gwas-gui
    mv rtm-gwas-gui $1/

elif [ $1 == "win32" ]; then

    i686-w64-mingw32-qmake-qt4
    make release

    i686-w64-mingw32-strip -s release/rtm-gwas-gui.exe
    mv release/rtm-gwas-gui.exe $1/

elif [ $1 == "win64" ]; then

    x86_64-w64-mingw32-qmake-qt4
    make release

    x86_64-w64-mingw32-strip -s release/rtm-gwas-gui.exe
    mv release/rtm-gwas-gui.exe $1/

fi
