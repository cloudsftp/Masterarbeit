#!/bin/bash

echo "Need root privileges"
sudo echo "Thank you"
echo
echo

INSTALL_DIR="$(pwd)/AnT"
#LIB_DIR="§{INSTALL_DIR}/lib64"

cd AnT-src

mkdir -p "$INSTALL_DIR"

./configure --prefix="$INSTALL_DIR" --enable-gui=no
[ $? -ne 0 ] && echo && echo Error configuring && exit 1
echo

make
[ $? -ne 0 ] && echo && echo Error compiling && exit 1
echo

sudo LD_LIBRARY_PATH="${INSTALL_DIR}/lib64" make install
[ $? -ne 0 ] && echo && echo Error installing && exit 1
echo
