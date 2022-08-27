#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# Start polybar
$HOME/.config/polybar/launch.sh &

# Start compositor
picom --config $HOME/.config/bspwm/picom.conf &

# xfce4 dependencies
run xfce4-power-manager &
run xfsettingsd &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

# update tray
# run pamac-tray &

# network tray
run nm-applet &
blueman-applet &
run insync start &
run volumeicon &

# conky -c $HOME/.config/bspwm/system-overview &
# run variety &

# numlockx on &


#nitrogen --restore &
#run caffeine &
#run vivaldi-stable &
#run firefox &
#run thunar &
#run dropbox &
#run discord &
