#!/bin/bash
#https://askubuntu.com/questions/442795/
#http://ubuntuforums.org/showthread.php?t=2172828

function showProgress(){
#
# Force Zenity Status message box to always be on top.
sleep 1 && wmctrl -r "Progress Status" -b add,above &

(
echo "# Shutting Down in 5" ; sleep 2
echo "25"
echo "# Shutting Down in 4" ; sleep 2
echo "50"
echo "# Shutting Down in 3" ; sleep 2
echo "75"
echo "# Shutting Down in 2" ; sleep 2
echo "99"
echo "# Shutting Down in 1" ; sleep 2
echo "# Shutting Down now" ; sleep 2
echo "100"

) |
zenity --progress \
  --title="Progress Status" \
  --text="First Task." \
  --percentage=0 \
 --auto-close

return $?

}


#idletime=$((1000*60*60*2)) # 2 hours in milliseconds
idletime=$((1000*3)) # test, 3seconds

while true; do
    idle=`xprintidle`
    echo $idle
    if (( $idle > $idletime )); then
        showProgress && \
        #sudo shutdown -P now
        #dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.PowerOff" boolean:true
        #echo for tests. use command above to actually shutdown
        echo shuting down the system. Just kidding  ^_^ \
        && exit 0
    fi
    sleep 1
done
