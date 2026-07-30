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
REMOTEPATH=$1
LOCALPATH=$2
FILE=$3
typeset -i FILECOUNT

usage ()
{
printf "\n${gr}
╭────┐Usage┌──────────────────────────────────────────────────────────────────────────────────────────────╮
│ gocryptfs-rclone-restore-help.sh ${norm} REMOTE-PATH LOCAL-PATH FILE-for-DIFF ${gr} $(tput hpa 105) │
│ e.g.: gocryptfs-rclone-restore-help.sh ${norm} pcloud:gcrfs/ae/gocryptfs_bigaex /mypath/myfolder/ myfile ${gr} $(tput hpa 105) │
╰─────────────────────────────────────────────────────────────────────────────────────────────────────────╯ 
${norm}"
}

difffunc ()
{
FILE1=$(find $LOCALPATH -type f -name "$FILE")
FILE2=$(echo $FILE1 |awk -F"${LOCALPATH}" '{print $2}')
printf "${gr}
╭────┐Info┌───────────────────────────────────────────────────────────────────────────────────────────────╮
│ FILE1:${norm} ${FILE1} ${gr} $(tput hpa 105) │
│ FILE2:${norm} ${RESTOREMNT}${FILE2} ${gr} $(tput hpa 105) │
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
│ REMOTE-PATH:${norm}   $REMOTEPATH ${gr} $(tput hpa 105) │
│ LOCAL-PATH:${norm}    $LOCALPATH ${gr} $(tput hpa 105) │
│ FILE-for-DIFF:${norm} $FILE ${gr} $(tput hpa 105) │
╰─────────────────────────────────────────────────────────────────────────────────────────────────────────╯ 
${norm}"

printf "${gr}
┌───────────────┐Mount┌─────────────────────────────────────────────────────────────────────────────╁
│ 
╰─╁ ${norm}"

mkdir -p $PCMOUNT $RESTOREMNT
rclone mount --vfs-cache-mode writes --read-only --daemon $REMOTEPATH $PCMOUNT
#df -h
gocryptfs -passfile ~/.GraHu $PCMOUNT $RESTOREMNT
df -h
sleep 2
ls -ltra $RESTOREMNT
sleep 2


FILECOUNT=$(find $LOCALPATH -type f -name "$FILE" |wc -l)

echo "$FILECOUNT"
if [ $FILECOUNT -ne 1 ] 
 then
  printf "${bl}
╭────┐Kein DIFF / No DIFF┌─────────────────────────╮ 
│ Datei existiert nicht oder mehr als einmal !     │
│ File does not exist or exists more than once !   │
╰──────────────────────────────────────────────────╯${norm}\n"
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











