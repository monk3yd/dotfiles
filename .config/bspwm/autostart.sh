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

# update tray
# run pamac-tray &

# network tray
run nm-applet &

# blueberry-tray &

# xfce4 dependencies
run xfce4-power-manager &
run xfsettingsd &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

# conky -c $HOME/.config/bspwm/system-overview &
# run variety &

# numlockx on &
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
