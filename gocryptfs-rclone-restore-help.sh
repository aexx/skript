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

usage ()
{
printf "\n${gr}
╭────┐Usage┌──────────────────────────────────────────────────────────────────────────────────────────────╮
│ gocryptfs-rclone-restore-help.sh ${norm}FILE-for-DIFF REMOTE-PATH LOCAL-PATH ${gr} $(tput hpa 105) │
│ e.g.: gocryptfs-rclone-restore-help.sh myfile pcloud:gcrfs/ae/gocryptfs_bigaex /mypath/myfolder/ $(tput hpa 105) │
╰─────────────────────────────────────────────────────────────────────────────────────────────────────────╯ 

${norm} "
}

if [ $# -lt 3 ]
 then
  usage ; echo
  exit 1
 else
  usage
fi

printf "\n${gr}
╭────┐Usage┌──────────────────────────────────────────────────────────────────────────────────────────────╮
│ FILE-for-DIFF: $1 $(tput hpa 105) │
│ REMOTE-PATH: $2  $(tput hpa 105) │
│ LOCAL-PATH: $3  $(tput hpa 105) │
╰─────────────────────────────────────────────────────────────────────────────────────────────────────────╯ 

${norm} "

printf "\n\n"
printf "${gr}┌───────────────┐Mount┌─────────────────────────────────────────────────────────────────────────────╁
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





#### umount
read -P____UMount_ALL____?____
printf "
${gr}┌───────────────┐UMount┌────────────────────────────────────────────────────────────────────────────╁
│ 
╰─╁ ${norm}"
sleep 2
fusermount -u $RESTOREMNT
sleep 2
fusermount -u $PCMOUNT
df -h











