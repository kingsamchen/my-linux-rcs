#!/bin/bash
#0xCCCCCCCC

set -e

INSTALL_DIR=${INSTALL_DIR:-$HOME/.rcs}

echo "Install dir: $INSTALL_DIR"

if [ ! -d $INSTALL_DIR ]; then
    echo 'Directory does not exist; create it first'
    mkdir -p $INSTALL_DIR
fi

echo `pwd` > $INSTALL_DIR/repo

cp ./rcs/resources.json $INSTALL_DIR

BIN_DIR=$INSTALL_DIR/bin
if [ ! -d $BIN_DIR ]; then
    mkdir -p $BIN_DIR
fi

cp ./rcs/rcs.py $BIN_DIR/rcs

NEW_PATH="PATH=\$PATH:$BIN_DIR"

SHRC=~/.`basename ${SHELL}`rc

if ! grep -Fxq "$NEW_PATH" $SHRC; then
    echo "" >> $SHRC
    echo $NEW_PATH >> $SHRC
    source $SHRC
fi

VER=`rcs --version`
echo "$VER has installed successfully!"
