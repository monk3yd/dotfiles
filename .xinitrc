#!/bin/sh

# Xorg start (xinit)
# Executed by startx (run your window manager from here)

# Source .xprofile (session). Make sure this is before the 'exec' command or it won't be sourced.
[ -f ~/.xprofile ] && . ~/.xprofile

# Source all files from /etc/X11/xinit/xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Set display
# Find out your monitor name with xrandr or arandr (save and you get this line)
xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate 144.00 --pos 0x0 --rotate normal

# change your keyboard if you need it
# setxkbmap -layout es
keybLayout=$(setxkbmap -v | awk -F "+" '/symbols/ {print $2}')

# Set background
# Some ways to set your wallpaper besides variety or nitrogen
feh --bg-fill /home/monk3yd/GDrive/theLab/wallpapers/favorites/jolly.png &

# Start bspwm
sxhkd -c ~/.config/bspwm/sxhkd/sxhkdrc &
exec bspwm -c ~/.config/bspwm/bspwmrc

# Start qtile
# exec qtile start
