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
typeset -i zaehler gesamtzaehler tageszaehler zeilen
zaehler=0
gesamtzaehler=0
tageszaehler=0
#sleep=0.001
sleep=60
LOCK=/dev/shm/`basename $0`.lock
LOG=/dev/shm/`basename $0`.log

[ -f $LOCK ] && { printf "\n${r}LOCK: $LOCK - dsl-check is running/ laeuft${n} \n" ; exit 1  ; }
touch $LOCK
printf "
     ╭───⦿ $(date +%F)  [.|:]⟾  Ping OK  [X]⟾  Ping FAIL
     │
     ╰──────────────────────30─Min╮───────────────────────60─Min╮
                                  │                             │
$(date +%H:%M)" >> $LOG
while true
do
 tageszaehler=$tageszaehler+1
 gesamtzaehler=$gesamtzaehler+1
 zaehler=$zaehler+1
 if ping -c1 google.com &> /dev/null
 #if true &> /dev/null
  then
  printf "." >> $LOG
 else
  printf "X" >> $LOG
 fi
 [ $zaehler -eq 10 ] && printf "\b:" >> $LOG
 [ $zaehler -eq 10 ] && zaehler=0
 [ $gesamtzaehler -eq 60 ] && printf "\n$(date +%H:%M)" >> $LOG
 [ $gesamtzaehler -eq 60 ] && gesamtzaehler=0
 #
 # Log kopieren
 zielordner=/media/fritz-smb/T7/alex/bigaex/Sicherung/RaspberryPi/
 zeilen=$(wc -l ${LOG}|cut -d " " -f1)
 [ ${zeilen} -gt 555 ] && [ -d ${zielordner} ] && cp $LOG ${zielordner}/dsl-check.sh_$(date +%F).log
 #
  [ $tageszaehler -eq 1440 ] && printf " >> $LOG
     ╭───⦿ $(date +%F)  [.|:]⟾  Ping OK  [X]⟾  Ping FAIL
     │
     ╰──────────────────────30─Min╮───────────────────────60─Min╮
                                  │                             │
$(date +%H:%M)" >> $LOG
 [ $tageszaehler -eq 1440 ] && tageszaehler=0
 sleep $sleep
done
