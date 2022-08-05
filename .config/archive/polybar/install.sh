#!/bin/bash

# Create necessary directory
mkdir -p ~/.config/polybar
mkdir -p ~/.config/polybar/scripts

# Updates polybar config files and scripts
for f in `find . -regex ".*\.py$\|.*\.sh$\|.config"`; do
    rm -rf ~/.config/polybar/${f}
    ln -s ~/.dotfiles/polybar/${f} ~/.config/polybar/${f}

    # Patch
    cp ~/.dotfiles/polybar/config ~/.dotfiles/polybar/config-original ~/.config/polybar
    # echo "Symlink created for file: ${f}"
done
