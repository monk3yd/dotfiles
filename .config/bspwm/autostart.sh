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

xsetroot -cursor_name left_ptr &

# conky -c $HOME/.config/bspwm/system-overview &
# run variety &
# run nm-applet &
# run pamac-tray &
# run xfce4-power-manager &
# numlockx on &
# blueberry-tray &
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# /usr/lib/xfce4/notifyd/xfce4-notifyd &
# run volumeicon &
#nitrogen --restore &
#run caffeine &
#run vivaldi-stable &
#run firefox &
#run thunar &
#run dropbox &
run insync start &
#run discord &
#run spotify &
#run atom &
