#!/bin/bash

r="\033[31m"
g="\033[32m"
gr="\033[37m"
b="\033[34m"
hb="\033[36m"
li="\033[35m"
n="\033[m\017"
bold=$(tput bold)
norm=$(tput sgr0)
typeset -i zaehler gesamtzaehler tageszaehler
zaehler=0
gesamtzaehler=0
tageszaehler=0
#sleep=0.001
sleep=60
LOCK=/tmp/`basename $0`.lock
[ -f $LOCK ] && { printf "\n\n\n${r}LOCK: $LOCK - Pruefen, ob Skript schon laeuft${n} \n\n\n" ; exit 1  ; }

printf "
     ╭───⦿ $(date +%F)  [.|:]⟾  Ping OK  [X]⟾  Ping FAIL
     │
     ╰──────────────────────30─Min╮───────────────────────60─Min╮
                                  │                             │
$(date +%H:%M)" 
while true
do
 tageszaehler=$tageszaehler+1
 gesamtzaehler=$gesamtzaehler+1
 zaehler=$zaehler+1
 if ping -c1 google.com &> /dev/null
 #if true &> /dev/null
  then
  printf "."
 else
  printf "X"
 fi
 [ $zaehler -eq 10 ] && printf "\b:"
 [ $zaehler -eq 10 ] && zaehler=0
 [ $gesamtzaehler -eq 60 ] && printf "\n$(date +%H:%M)"
 [ $gesamtzaehler -eq 60 ] && gesamtzaehler=0
 [ $tageszaehler -eq 1440 ] && printf "
     ╭───⦿ $(date +%F)  [.|:]⟾  Ping OK  [X]⟾  Ping FAIL
     │
     ╰──────────────────────30─Min╮───────────────────────60─Min╮
                                  │                             │
$(date +%H:%M)"
 [ $tageszaehler -eq 1440 ] && tageszaehler=0
 sleep $sleep
done
