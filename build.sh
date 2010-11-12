#!/bin/sh

PKGCONFIG=pkg-config-0.25
LIBICONV=libiconv-1.13.1
LIBPNG=libpng-1.4.4
PIXMAN=pixman-0.19.6
FONTCONFIG=fontconfig-2.8.0
POPPLER=poppler-0.14.4
CAIRO=cairo-1.10.0
EXPAT=expat-2.0.1
GETTEXT=gettext-0.18.1.1
GLIB=glib-2.26.0
PANGO=pango-1.28.3
RRDTOOL=rrdtool-1.4.4
LIBXML=libxml2-2.7.7
FREETYPE=freetype-2.4.3

STAGE=$PWD/stage

PKG_CONFIG=$STAGE/bin/pkg-config
PKG_CONFIG_PATH=$STAGE/lib/pkgconfig  
PATH=$PATH:$STAGE/bin
CFLAGS="-mmacosx-version-min=10.5 -isysroot /Developer/SDKs/MacOSX10.5.sdk -Wl,-search_paths_first -O -arch i386 -I$STAGE/include"
LDFLAGS="-L$STAGE/lib -arch i386" 

CONFIGURE_FLAGS="--disable-dependency-tracking --prefix=$STAGE --enable-static --sysconfdir=/usr/local/etc"

#
# Staging
#

rm -rf $STAGE
mkdir -p $STAGE

# 
# Build 
#

# pkg-config
tar zxvf $PKGCONFIG.tar.gz
cd $PKGCONFIG
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $PKGCONFIG

# libiconv
tar zxvf $LIBICONV.tar.gz
cd $LIBICONV
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $LIBICONV

# libpng
tar zxvf $LIBPNG.tar.gz
cd $LIBPNG
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $LIBPNG

# pixman
tar zxvf $PIXMAN.tar.gz
cd $PIXMAN
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $PIXMAN

# freetype
tar zxvf $FREETYPE.tar.gz
cd $FREETYPE
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure --prefix=$STAGE --enable-static && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $FREETYPE

# fontconfig
tar zxvf $FONTCONFIG.tar.gz
cd $FONTCONFIG
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS --with-add-fonts=/System/Library/Fonts --with-freetype-config=$STAGE/bin/freetype-config && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $FONTCONFIG

# poppler
tar zxvf $POPPLER.tar.gz
cd $POPPLER
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS --disable-poppler-qt --disable-poppler-qt4 --enable-xpdf-headers --enable-zlib --disable-gtk-test --without-x
if [ $? -ne 0 ]; then
  exit 1
fi
sed -i '' -e "s/DEFAULT_INCLUDES \=/DEFAULT_INCLUDES \= -I..\/..\/stage\/include/" cpp/Makefile
if [ $? -ne 0 ]; then
  exit 1
fi
make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $POPPLER

# cairo
tar zxvf $CAIRO.tar.gz
cd $CAIRO
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS --enable-static --enable-xlib=no --enable-xlib-render=no --enable-win32=no && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $CAIRO

# expat
tar zxvf $EXPAT.tar.gz
cd $EXPAT
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $EXPAT

# gettext
tar zxvf $GETTEXT.tar.gz
cd $GETTEXT
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $GETTEXT

# libxml
tar zxvf $LIBXML.tar.gz
cd $LIBXML
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $LIBXML

# glib
tar zxvf $GLIB.tar.gz
cd $GLIB
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $GLIB

# pango
tar zxvf $PANGO.tar.gz
cd $PANGO
sed -i '' -e 's/have_atsui=true/have_atsui=false/g' configure
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS --with-dynamic-modules=no --with-included-modules=basic-fc --enable-static --without-x && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $PANGO

# rrdtool
tar zxvf $RRDTOOL.tar.gz
cd $RRDTOOL
CFLAGS=$CFLAGS \
CXXFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
PKG_CONFIG=$PKG_CONFIG \
PKG_CONFIG_PATH=$PKG_CONFIG_PATH \
./configure $CONFIGURE_FLAGS --disable-rrdcgi --enable-static-programs \
  --disable-libdbi --disable-perl --disable-ruby --disable-lua --disable-tcl\
  PKGCONFIG=$PKG_CONFIG && make && sudo make install
if [ $? -ne 0 ]; then
  exit 1
fi
cd ..
rm -rf $RRDTOOL

#
# Get Result
#

rm -rf result
mkdir -p result
cp $STAGE/bin/rrd* result
rm -rf $STAGE

echo "----------------------------------------------------------------------"
echo "The static build of RRDtool has completed and the rrdtool, rrdupdate"
echo "and rrdcached binaries can be found in the 'result' directory"
echo "----------------------------------------------------------------------"
