#!/bin/bash

function run {
  if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null;
  then
    $@&
  fi
}

#Find out your monitor name with xrandr or arandr (save and you get this line)
xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate 144.00 --pos 0x0 --rotate normal

# change your keyboard if you need it
# setxkbmap -layout es

keybLayout=$(setxkbmap -v | awk -F "+" '/symbols/ {print $2}')

# autostart ArcoLinux Welcome App
# run dex $HOME/.config/autostart/arcolinux-welcome-app.desktop &

# For authentication
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# start compositor
picom --config $HOME/.config/qtile/scripts/picom.conf &

# Some ways to set your wallpaper besides variety or nitrogen
feh --bg-fill /home/monk3yd/.config/wallpapers/arcolinux-candy-09.jpg &

# start sxhkd to replace Qtile native key-bindings
run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

# Enable network manager
run nm-applet &

# Enable update manager
run pamac-tray &

# Enable power management
run xfce4-power-manager &

#
numlockx on &

# Enable bluetooth
run blueman-applet &

#
/usr/lib/xfce4/notifyd/xfce4-notifyd &

# Start insync
run insync start &

# Start wallpaper manager
run variety &

run betterlockscreen -l &

# Enable volume manager
sleep 13
run volumeicon &

# Start terminal
# run alacritty

# run thunar &
# run firefox &
# run discord &
# nitrogen --restore &
# run todoist &



#start the conky to learn the shortcuts
# (conky -c $HOME/.config/qtile/scripts/system-overview) &
