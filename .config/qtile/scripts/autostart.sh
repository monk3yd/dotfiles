#!/bin/bash

function run {
  if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null;
  then
    $@&
  fi
}

#Set your native resolution IF it does not exist in xrandr
#More info in the script
#run $HOME/.config/qtile/scripts/set-screen-resolution-in-virtualbox.sh

#Find out your monitor name with xrandr or arandr (save and you get this line)
xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate 144.00 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#autorandr horizontal

#change your keyboard if you need it
#setxkbmap -layout be

keybLayout=$(setxkbmap -v | awk -F "+" '/symbols/ {print $2}')

# if [ $keybLayout = "be" ]; then
#   cp $HOME/.config/qtile/config-azerty.py $HOME/.config/qtile/config.py
# fi

# autostart ArcoLinux Welcome App
# run dex $HOME/.config/autostart/arcolinux-welcome-app.desktop &

# Some ways to set your wallpaper besides variety or nitrogen
feh --bg-fill /usr/share/backgrounds/arcolinux-candy/candy-09.jpg &

# start sxhkd to replace Qtile native key-bindings
run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

# start compositor
picom --config $HOME/.config/qtile/scripts/picom.conf &

# starting applications at boot time
run nm-applet &
run pamac-tray &
run blueman-applet &
run volumeicon &
run insync start &

run alacritty

# run firefox &
# run thunar &
# run discord &
# nitrogen --restore &
# run todoist &
# run variety &
numlockx on &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

# run xfce4-power-manager &

#start the conky to learn the shortcuts
# (conky -c $HOME/.config/qtile/scripts/system-overview) &
