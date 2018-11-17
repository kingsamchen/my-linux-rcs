#!/bin/bassh
# 0xCCCCCCCC

set -e

INSTALL_DIR=${INSTALL_DIR:-$HOME/.local/my-rcs}

echo "Install dir: $INSTALL_DIR"

if [ ! -d $INSTALLER_DIR ]; then
    echo 'Directory does not exist; create it first'
    mkdir -p $INSTALL_DIR
else
    echo 'Directory already exists.'
fi

cp -iR ./rcs/. $INSTALL_DIR

echo "Files are deployed to $INSTALL_DIR"

# Setup init.sh

if [ "$SHELL" = "/bin/zsh" ]; then
    SHRC="$HOME/.zshrc"
elif [ "$SHELL" = "/bin/bash" ]; then
    SHRC="$HOME/.bashrc"
fi

echo "Shell-rc: $SHRC"

LINE="source $INSTALL_DIR/init.sh"
if ! grep -Fxq "$LINE" $SHRC; then
    echo "" >> $SHRC
    echo "$LINE" >> $SHRC
    echo "" >> $SHRC
    echo "Command for sourcing init.sh is added"
fi

source $SHRC

# TODO: wgetrc

# TODO: tmux-conf
