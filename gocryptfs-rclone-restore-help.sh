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
╭────┐Usage┌───────────────────────────────────────────────────────────────────────────────╮
│                                                                                          │
│ $(basename $0) ${norm}filename-to-find-for-restore REMOTE-PATH [LOCAL-PATH] ${gr} $(tput hpa 90) │
│                                                                                          │
│ e.g.: $(basename $0) testinger pcloud:gcrfs/ae/gocryptfs_bigaex  $(tput hpa 90) │
│                                                                                          │
╰──────────────────────────────────────────────────────────────────────────────────────────╯ "
}

if [ $# -lt 2 ]
 then
  usage ; echo
  exit 1
 else
  usage
fi

if [ -z $2 ] 
   then
    LOCALDIR=${HOME}/bigaex/ 
   else
    LOCALDIR=${2}
  fi


printf "\n\n"
printf "${gr}┌───────────────┐Mount┌────────────────────────────────────────────╁"

mkdir -p $PCMOUNT $RESTOREMNT

rclone mount --vfs-cache-mode writes --read-only $2 $PCMOUNT
df -ha

gocryptfs -passfile ~/.GraHu $PCMOUNT $RESTOREMNT

df -ha
ls -ltra $RESTOREMNT

kreiselnala 3 || sleep 3

fusermount -u $RESTOREMNT
kreiselnala 3 || sleep 3
fusermount -u $PCMOUNT
df -ha











