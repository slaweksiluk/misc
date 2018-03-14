#!/bin/bash
# This script builds GHDL with gcc backend
# TODO parse sources directories from cmd line

# Paramaters
GHDL_SRC_DIR="$HOME/git/github/ghdl"
GCC_SRC_DIR="$HOME/sources/gcc-7.3.0"
INSTALL_PREFIX="$HOME/install_prefix"

echo $GHDL_SRC_DIR
echo $GCC_SRC_DIR
echo $INSTALL_PREFIX

echo "Check for necessary commnads"
if ! [ -x "$(command -v g++)" ]; then
  echo 'Error: g++ is not installed.' >&2
  exit 1
fi

# Exit on error
#set -e

# Prepare ghdl sources
cd $GHDL_SRC_DIR &&
mkdir build ; cd build &&
../configure --with-gcc=$GCC_SRC_DIR --prefix=$INSTALL_PREFIX &&
make copy-sources

# Dowonload prerequisites for gcc
cd $GCC_SRC_DIR && ./contrib/download_prerequisites

# Compile ghdl with gcc backend
cd $GHDL_SRC_DIR/build && mkdir gcc-objs ; cd gcc-objs &&
$GCC_SRC_DIR/configure --prefix=$INSTALL_PREFIX --enable-languages=c,vhdl --disable-bootstrap --disable-lto --disable-multilib --disable-libssp --disable-libgomp --disable-libquadmath &&
make -j2 &&
make install MAKEINFO=true

## Install ghdl libs
cd $GHDL_SRC_DIR/build &&
make ghdllib &&
make install


