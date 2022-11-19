#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# Start polybar
# $HOME/.config/polybar/launch.sh &

# Start compositor
# picom --config $HOME/.config/bspwm/picom.conf &

# xfce4 dependencies
run xfce4-power-manager &
# run xfsettingsd &  # (appearance changed by lxappearance)
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

# update tray
# run pamac-tray &

# network tray
# run nm-applet &
run blueman-applet &
run insync start &

# sleep 15
# run volumeicon &

run alacritty

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
