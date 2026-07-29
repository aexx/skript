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



usage ()
{
        printf "\n${gr}
╭────┐Usage┌───────────────────────────────────────────────────────────────────────────────╮
│                                                                                          │
│ $(basename $0) ${norm}filename-to-find-for-restore REMOTE-PATH [LOCAL-PATH] ${gr} $(tput hpa 90) │
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
printf "${gr}┌───────────────┐$0┌────────────────────────────────────────────╁"


