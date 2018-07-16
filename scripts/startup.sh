#!/bin/sh

#Disable mouse acceleration
xinput --set-prop "G-Tech Wireless Dongle" "Device Accel Profile" -1
xinput --set-prop "pointer:G-Tech Wireless Dongle" "libinput Accel Profile" -1
xinput --set-prop "pointer:G-Tech Wireless Dongle"  278 -1

xrandr --output HDMI-2 --same-as eDP-1

#Mirror displays
xrandr --output HDMI-0 --same-as DP-5

#Set dvorak; swap left ctrl and caps
setxkbmap dvorak -option ctrl:nocaps

#Make caps behave as ctrl and escape
#Only run if not already running
pgrep xcape || xcape

#Setup Wacom tablet
#xsetwacom --set "Wacom Bamboo Connect Pen stylus" MapToOutput "1920x1080+1920+0"
xsetwacom --set "Wacom Bamboo Connect Pen stylus" MapToOutput desktop

pgrep redshift || redshift &