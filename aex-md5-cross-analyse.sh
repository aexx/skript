#!/bin/bash

typeset -i zaehler
zaehler=0

usage () {
printf "Usage: \n
 `basename $0`  some-sort_md5-File-01  other_sort_md5-File-02 \n
 e.g.: `basename $0`  md5list2024-06-12_1147_aspi_home_aex_sort_md5  md5list2024-06-12_1148_aspi_media_Intenso_aex_sort_md5 \n\n"
}

#printf "\n\nAnzahl,Count Parameters: $# \n\n"

if [ $# -ne 2 ]
    then
    usage
    exit 1
fi


cross-analyse () { 
printf "\n╭─── MD5 Cross Analyse ────────────────────────────────────────────────────────────────────────────────────╮ "
printf "\n│ MD5 file Cross-check / Gegen-check    [.] => 50 , [:] => 100 files /.Dateien.                            │ "
printf "\n│ Nicht identische Dateien werden unten angezeigt / files that are not identical are displayed below.      │ "
printf "\n╰──────────────────────────────────────────────────────────────────────────────────────────────────────────╯ "
printf "\n╭──────────────────────────────────────────────────────────────────────────────────────────────────────────╮ "
printf "\n╰────────╮1000 ──────────────────────────────────╮5000 ────────────────────────────────────────────╮10000 ─╯ "
cat $1 |while read line
do 
  zaehler=$zaehler+1
  nurmd5=$(echo $line|cut -c-32)
  grep -q $nurmd5 $2 || printf "
╰───────────────────────────────────────────────────────────────────────────────────────────────────────────╮
Check ==> $line <== \n
╰────────╮1000 ──────────────────────────────────╮5000 ────────────────────────────────────────────╮10000 ──╮\n"
  #printf " $zaehler  "
  #[ $zaehler -eq 10 -o $zaehler -eq 20 -o $zaehler -eq 30 -o $zaehler -eq 40 -o $zaehler -eq 50 ] && printf "."
  #[ $zaehler -eq 60 -o $zaehler -eq 70 -o $zaehler -eq 80 -o $zaehler -eq 90 -o $zaehler -eq 100 ] && printf "."
  #[ $zaehler -eq 100 ] && printf "\b\b\b\b\b\b\b\b\b\b:"
  [ $zaehler -eq 50 ] && printf "."
  [ $zaehler -eq 100 ] && printf "\b:"
  [ $zaehler -eq 100 ] && zaehler=0
done 
}

clear

cross-analyse $1 $2
printf "\n
______________________________________________________

 Dateien werden getauscht, files are swapped
______________________________________________________ \n\n"
cross-analyse $2 $1

printf "\n\n"
