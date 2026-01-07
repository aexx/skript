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
norm=$(tput sgr0)

printf "\n\n"
rclone listremotes|while read a
 do 
  printf "${gr}┌───────────────┐$a┌────────────────────────────────────────────╁"
  kreiselnala 2 || sleep 2
  printf "\n│${norm}$(rclone about ${a})\n"
  printf "${gr}└─────────┐${norm}\n"
  rclone lsd $a
done
echo
lt .config/rclone


