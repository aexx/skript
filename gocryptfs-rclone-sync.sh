#!/bin/bash
r="\033[31m"
g="\033[32m"
gr="\033[37m"
b="\033[34m"
hb="\033[36m"
li="\033[35m"
n="\033[m\017"
#
# ┌──┬──┐
# │  │  │
# ├──┼──┤
# │  │  │
# └──┴──┘
# ╭─┐blub┌───┬──┬──╮
# │          │  │  │ 
# │          ├──┼──┤ 
# │          │  │  │ 
# ╰──────────┴──┴──╯
WAIT () { kreiselnala b $1 2>/dev/null || sleep $1; }
usage ()
{
        printf "\n${g}
╭────┐Usage┌────────────────────────────────────────────────────────────────────────╮
│                                                                                   │
│ $(basename $0) ${n}Pass-File Data-Path gocryptfs-Path rclone-Remote-Path${g} $(tput hpa 83) │
│                                                                                   │
╰───────────────────────────────────────────────────────────────────────────────────╯ "
}

#tput cup 0 0
#tput ed
if [ $# -lt 4 ]
 then
  usage ; echo
  exit 1
 else
  usage
fi

printf "${g} $(tput hpa 55)┬\n$(tput hpa 55)│
╭───────┐List All rclone Remotes┌──────────────────────╯
│${n}\n"

#rclone listremotes|while read a; do echo "===[ $a ]===";sleep 1;rclone about $a; done
rclone listremotes|while read a
do 
 printf "╰───────┐$a\n " 
 rclone about $a
 #printf "%-50s" "╭────" |sed -e "s/ /─/g" ; printf "$(tput hpa 40)╯"
done
WAIT 1
printf "${g}
╭────┐Sync gocryptfs to rclone Remotes┌─────────────────────────────────╮
│ Password-File:      ${n} $1 ${g} $(tput hpa 71) │
│ Data-Folder:        ${n} $2 ${g} $(tput hpa 71) │
│ gocryptfs-Folder:   ${n} $3 ${g} $(tput hpa 71) │
│ rclone-Remote-Path: ${n} $4 ${g} $(tput hpa 71) │
╰───────────────────────────────────────────────────────────────────────╯ "
printf "${g} $(tput hpa 62)┬\n$(tput hpa 62)│
╭───────┐Mount gocryptfs-Folder┌──────────────────────────────╯
│${n}\n"
[ -s ${2}/.gocryptfs.reverse.conf ] || printf "${r}\n  ──────┤!!! Data-Folder NOT OK !!!├──────${n}\n"
[ -s ${2}/.gocryptfs.reverse.conf ] || exit 1
echo gocryptfs -passfile $1 -reverse $2 $3
mount |grep $3 && printf "${r}\n  ──────┤!!! gocryptfs-Folder MOUNTED !!!├──────${n}\n"
mount |grep $3 || gocryptfs -passfile $1 -reverse $2 $3
[ -s ${3}/gocryptfs.conf ] || printf "${r}\n  ──────┤!!! gocryptfs-Folder NOT OK !!!├──────${n}\n"
[ -s ${3}/gocryptfs.conf ] || exit 1
WAIT 5
#printf "${g} $(tput hpa 55)┬\n$(tput hpa 55)│"
printf "${g}│
╰───────┐SYNC gocryptfs-Folder┌───────────────────────────────╮
╭─────────────────────────────────────────────────────────────╯
│${n}\n"
rclone lsl ${4}/gocryptfs.conf || printf "${r}\n  ──────┤!!! rclone-Remote-Path NOT OK !!!├──────${n}\n"
[ -s ${3}/gocryptfs.conf ] && rclone lsl ${4}/gocryptfs.conf && time rclone sync -vP $3 $4
printf "${g}│
╰───────┐CHECK SYNC┌──────────────────────────────────────────╮
╭───────────────────────────────────────────────╯UMOUNT╰──────╯
│${n}\n"
WAIT 10
time rclone check -vP $3 $4
WAIT 5
fusermount -u $3
#
