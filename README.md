# monk3yd system

### Add bare repo for administration of configuration files:
https://www.youtube.com/watch?v=tBoLDpTWVOM&t=155s
1. git init --bare $HOME/dotfiles
2. alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' (add this alias to .bashrc/.zshrc)
3. bash|zsh
4. config config --local status.showUntrackedFiles no

### Installs - TODO create bash script for installing
#### WMs
- qtile

#### Text Editors
- neovim (source)
- vscodium (init.vim; settings.json; keybindings.json)

#### Hotkeys & Keybindings (Daemon)
- sxhkd

#### Terminals
- alacritty
- kitty

#### Web Browsers
- firefox

#### Window Switcher & SSH Launcher
- rofi

#### File Manager
- thunar

#### Shell
- zsh

#### Version Control System (VCS)
- git (generate ssh key)
- lazygit

#### Containers
- docker

#### Python Package Manager
- pip
#### Fonts
- nerdfonts (script)
- Fontforge (AppImage)
- MonoLisa + icons nerdfont patch

#### Cloud Sync, Storage & Backup
- insync (~/GDrive...)

#### Screenshots
- flameshot

#### Chat
- discord

#### Gaming
- steam

#### Video Player
- vlc

#### Image Editor
- gimp

#### Images & Wallpapers
- feh (image viewer & wallpaper manager)
- nitrogen (wallpaper manager)
- nomacs (image viewer)
- variety (wallpaper manager)

#### Virtualization
- virtualbox
- valgrind*

#### Archlinux Tools
- archlinux-tweak-tool
- archlinux-betterlockscreen

#### ISO
- balenaEtcher (usb ISO writer)

### Important files
- autostart.sh
- picom.conf
- X/
- bash scripts:
  - installer.sh

### Actions
- change sddm background image
- change betterlockscreen background image

### btrfs snapshot
- btrfs assistant
- snapper

### wanna install/testing
- variety

### Extra WMs
- awesome
- xmonad
- bspwm
