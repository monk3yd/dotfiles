#!/bin/bash

function run {
  if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null;
  then
    $@&
  fi
}

# autostart ArcoLinux Welcome App
# run dex $HOME/.config/autostart/arcolinux-welcome-app.desktop &

# For authentication
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# start compositor
picom --config $HOME/.config/qtile/scripts/picom.conf &

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

# Lock display at boot
betterlockscreen -l &

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
