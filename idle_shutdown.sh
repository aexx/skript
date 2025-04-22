#!/bin/bash
#
# This is probably the best solution. No need for screensaver tweaking and running.
# Install sudo apt-get install xprintidle
# Put this script into autostart:

typeset -i idletime
typeset -i idle

idletime=$((1000*60*60*2)) # 2 hours in milliseconds

while true; do
    idle=`xprintidle`
    echo $idle
    if (( $idle > $idletime )); then
        #sudo shutdown -P now
        dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.PowerOff" boolean:true
    fi
    sleep 1
done
