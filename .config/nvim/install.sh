#!/bin/bash
# Install nvim config files & directories

# Create required directories
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/lua
mkdir -p ~/.config/nvim/lua/monk3yd/lualine/themes
mkdir -p ~/.config/nvim/plugin
mkdir -p ~/.config/nvim/lua/monk3yd/bfs

# Find all config files and symlink them over to nvim config directories
for f in `find . -regex ".*\.lua$"`; do
    rm -rf ~/.config/nvim/${f}
    ln -s ~/.dotfiles/neovim/${f} ~/.config/nvim/${f}
    # echo "Symlink created for file: ${f}"
done
