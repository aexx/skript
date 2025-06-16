#!/bin/bash

typeset -i zaehler gesamtzaehler tageszaehler
zaehler=0
gesamtzaehler=0
tageszaehler=0
#sleep=0.001
sleep=60
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
