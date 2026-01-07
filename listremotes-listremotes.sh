#!/bin/bash

printf "\n\n"
rclone listremotes|while read a
 do 
  printf "┌───────────────┐$a┌────────────────────────────────────────────╁"
  sleep 2
  printf "\n│$(rclone about ${a})\n"
  printf "└─────────┐\n"
  rclone lsd $a
done
echo
lt .config/rclone


