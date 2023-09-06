#!/bin/sh
# Install this configuration bundle

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 
INSTALL_DIR=~/.config/nvim

echo "-------------------------------------"
ln -svf $SCRIPT_DIR $INSTALL_DIR
echo "nvim config installed at $INSTALL_DIR"
echo "welcome to the dark side! ;)"
echo "-------------------------------------"
