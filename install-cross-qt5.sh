#!/bin/bash

if [[ ! -f /etc/centos-release ]]; then
    cat /etc/os-release | head -2
    echo "ERROR: CentOS Linux is required"
    exit 1
fi

if [[ $# -ne 1 ]]; then
    echo "ERROR: invalid argument"
    echo "./install-cross-qt5.sh glnx64|win64|win32"
    exit 1
fi

rm -rf $1

if [[ -f Makefile ]]; then
    make distclean
fi

if [[ $1 = "glnx64" ]]; then

    qmake-qt5 src || exit 1
    make || exit 1

    # sudo apt install libqt5widgets5
    # sudo yum install qt5-qtbase-gui
    mkdir $1
    cp rtm-gwas-gui $1/
    strip -s $1/rtm-gwas-gui

elif [[ $1 = "win32" ]]; then

    mingw32-qmake-qt5 src || exit 1
    make release || exit 1

    mkdir $1
    cp release/rtm-gwas-gui.exe $1/
    mingw-strip -s $1/rtm-gwas-gui.exe

    MINGW=/usr/i686-w64-mingw32/sys-root/mingw
    PLUGIN_PLATFORMS=$MINGW/lib/qt5/plugins/platforms

    cp $MINGW/bin/iconv.dll             $1/
    cp $MINGW/bin/libgcc_s_sjlj-1.dll   $1/
    cp $MINGW/bin/libGLESv2.dll         $1/
    cp $MINGW/bin/libglib-2.0-0.dll     $1/
    cp $MINGW/bin/libharfbuzz-0.dll     $1/
    cp $MINGW/bin/libintl-8.dll         $1/
    cp $MINGW/bin/libpcre-1.dll         $1/
    cp $MINGW/bin/libpcre16-0.dll       $1/
    cp $MINGW/bin/libpng16-16.dll       $1/
    cp $MINGW/bin/libstdc++-6.dll       $1/
    cp $MINGW/bin/libwinpthread-1.dll   $1/
    cp $MINGW/bin/Qt5Core.dll           $1/
    cp $MINGW/bin/Qt5Gui.dll            $1/
    cp $MINGW/bin/Qt5Widgets.dll        $1/
    cp $MINGW/bin/zlib1.dll             $1/
    cp -r $PLUGIN_PLATFORMS             $1/

elif [[ $1 = "win64" ]]; then

    mingw64-qmake-qt5 src || exit 1
    make release || exit 1

    mkdir $1
    cp release/rtm-gwas-gui.exe $1/
    mingw-strip -s $1/rtm-gwas-gui.exe

    MINGW=/usr/x86_64-w64-mingw32/sys-root/mingw
    PLUGIN_PLATFORMS=$MINGW/lib/qt5/plugins/platforms

    cp $MINGW/bin/iconv.dll             $1/
    cp $MINGW/bin/libgcc_s_seh-1.dll    $1/
    cp $MINGW/bin/libGLESv2.dll         $1/
    cp $MINGW/bin/libglib-2.0-0.dll     $1/
    cp $MINGW/bin/libharfbuzz-0.dll     $1/
    cp $MINGW/bin/libintl-8.dll         $1/
    cp $MINGW/bin/libpcre-1.dll         $1/
    cp $MINGW/bin/libpcre16-0.dll       $1/
    cp $MINGW/bin/libpng16-16.dll       $1/
    cp $MINGW/bin/libstdc++-6.dll       $1/
    cp $MINGW/bin/libwinpthread-1.dll   $1/
    cp $MINGW/bin/Qt5Core.dll           $1/
    cp $MINGW/bin/Qt5Gui.dll            $1/
    cp $MINGW/bin/Qt5Widgets.dll        $1/
    cp $MINGW/bin/zlib1.dll             $1/
    cp -r $PLUGIN_PLATFORMS             $1/

else

    echo "ERROR: invalid argument: $1"
    echo "./install-cross-qt5.sh glnx64|win64|win32"
    exit 1

fi