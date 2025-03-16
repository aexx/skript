#!/bin/bash
#
LOCK=/tmp/lock.shut-auto.lock
typeset -i zaehler
zaehler=44
export LC_ALL=C

if [ -f $LOCK ]; then
  printf "\n  $(date +%Y-%m-%d_%H%M) $LOCK - EXIT \n"
  exit 1
fi  
 
touch $LOCK
printf "\n__ $(date +%Y-%m-%d_%H%M) __ $(cat /proc/loadavg|cut -c-15)  _s_"

nettrafstat () { 
    export LC_ALL=C
    echo -en "  Network: active.. " 
    while [ $zaehler -ge 0 ]; do
        neteins=$(/sbin/ifconfig |grep "packets")
	sleep 1.25
        netzwei=$(/sbin/ifconfig |grep "packets")
        [ "$neteins" = "$netzwei" ] || echo -en "..$zaehler "
        [ "$neteins" = "$netzwei" ] && echo -e "INACTIVE....$zaehler "
        [ "$neteins" = "$netzwei" ] && break
        zaehler=$zaehler-1 
    done;
    #[ "$neteins" = "$netzwei" ] && echo GLEICH
    [ "$neteins" = "$netzwei" ] && return 0
    [ -f $LOCK ] && rm $LOCK ; exit 1
}

mountcheck () {
mount |egrep -q "/dev/sda1.*/media/INTENSO2" && printf "  INTENSO2 mounted - exit " && [ -f $LOCK ] && rm $LOCK
mount |egrep -q "/dev/sda1.*/media/INTENSO2" && exit 1
}

logincheck () {
[ -z "`who`" ] || ( printf "  USER: $(who|cut -c-20|tr "\n" ":") " ; [ -f $LOCK ] && rm $LOCK )
[ -z "`who`" ] || exit 1 
}

loadcheck () {
#cat /proc/loadavg|grep -q "0\.0. 0\.0. 0\.0. " || ( printf "  CPULOAD hoch/high " ; [ -f $LOCK ] && rm $LOCK )
#cat /proc/loadavg|grep -q "0\.0. 0\.0. 0\.0. " || exit 1 
cat /proc/loadavg|grep -q "0\.00 0\.0[012] 0\.0[012345] " || ( printf "  CPULOAD hoch/high " ; [ -f $LOCK ] && rm $LOCK )
cat /proc/loadavg|grep -q "0\.00 0\.0[012] 0\.0[012345] " || exit 1

}

mountcheck
logincheck
loadcheck
nettrafstat

[ -f $LOCK ] && rm $LOCK
printf " .... Jetzt SHUTDOWN .... \n"
/sbin/init 0

# ende
