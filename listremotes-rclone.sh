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

printf "\n\n"
rclone listremotes|while read a
 do 
  printf "${gr}┌───────────────┐$a┌────────────────────────────────────────────╁"
  sleep 1
  printf "\n│$(rclone about ${a}|sed -e 's/Fr/│Fr/'|sed -e 's/Tr/│Tr/'|sed -e 's/Us/│Us/' )\n"
  printf "└─────────┐${norm}\n"
  rclone lsd $a
done
echo
ls -ltra .config/rclone


