#!/bin/bash

sc="$(tput setaf 0)"
ro="$(tput setaf 1)"
gr="$(tput setaf 2)"
ge="$(tput setaf 3)"
bl="$(tput setaf 4)"
ma="$(tput setaf 5)"
hb="$(tput setaf 6)"
we="$(tput setaf 7)"
fett=$(tput bold)
bon=$(tput smso)  # set bold on
boff=$(tput rmso) # remove bold
norm=$(tput sgr0)
PCMOUNT=/dev/shm/pcloudmount
RESTOREMNT=/dev/shm/restoremount

typeset -i FILECOUNT

usage ()
{
printf "\n${gr}
╭────┐Usage┌──────────────────────────────────────────────────────────────────────────────────────────────╮
│ gocryptfs-rclone-restore-help.sh ${norm} FILE-for-DIFF REMOTE-PATH LOCAL-PATH ${gr} $(tput hpa 105) │
│ e.g.: gocryptfs-rclone-restore-help.sh ${norm} myfile pcloud:gcrfs/ae/gocryptfs_bigaex /mypath/myfolder/ ${gr} $(tput hpa 105) │
╰─────────────────────────────────────────────────────────────────────────────────────────────────────────╯ 
${norm}"
}

difffunc ()
{
FILE1=$(find $3 -type f -name "$1")


printf "${gr}
╭────┐Info┌───────────────────────────────────────────────────────────────────────────────────────────────╮
│ FILE1=${norm} $FILE1 ${gr} $(tput hpa 105) │
│ FILE2=${norm} $FILE2 ${gr} $(tput hpa 105) │
╰─────────────────────────────────────────────────────────────────────────────────────────────────────────╯ 
${norm}"

}

if [ $# -lt 3 ]
 then
  usage ; echo
  exit 1
 else
  usage
fi

printf "${gr}
╭────┐Info┌───────────────────────────────────────────────────────────────────────────────────────────────╮
│ FILE-for-DIFF:${norm} $1 ${gr} $(tput hpa 105) │
│ REMOTE-PATH:${norm}   $2 ${gr} $(tput hpa 105) │
│ LOCAL-PATH:${norm}    $3 ${gr} $(tput hpa 105) │
╰─────────────────────────────────────────────────────────────────────────────────────────────────────────╯ 
${norm}"

printf "${gr}
┌───────────────┐Mount┌─────────────────────────────────────────────────────────────────────────────╁
│ 
╰─╁ ${norm}"

mkdir -p $PCMOUNT $RESTOREMNT
rclone mount --vfs-cache-mode writes --read-only --daemon $2 $PCMOUNT
#df -h
gocryptfs -passfile ~/.GraHu $PCMOUNT $RESTOREMNT
df -h
sleep 2
ls -ltra $RESTOREMNT
sleep 2


FILECOUNT=$(find $3 -type f -name "$1" |wc -l)

echo "$FILECOUNT"
if [ $FILECOUNT1 -gt 1 ] 
 then
  printf "${bl}\nDatei existiert mehr als einmal - kein DIFF / file exists more than once - no DIFF ${norm}\n"
 else
  difffunc
fi
  

#### umount
printf "${bl}
╭────┐${fett}UMount ?${norm}${bl}┌───────────────────────────────────────────╮
╰───────────────────────────┐${fett}ENTER${norm}${bl}┌────┐${fett}CTRL+C${norm}${bl}┌───────────╯${norm}
"
read
printf "
${gr}┌───────────────┐UMount┌────────────────────────────────────────────────────────────────────────────╁
│ 
╰─╁ ${norm}"
sleep 2
fusermount -u $RESTOREMNT
sleep 2
fusermount -u $PCMOUNT
df -h











