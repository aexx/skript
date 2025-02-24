#!/bin/bash
r="\033[31m"
g="\033[32m"
gr="\033[37m"
b="\033[34m"
hb="\033[36m"
li="\033[35m"
n="\033[m\017"
WAIT () { kreisel b $1 2>/dev/null || sleep $1; }
usage ()
{
	printf "\n${g}
╭──── Usage  ───────────────────────────────────────────────────────────────╮
│                                                                           │
│ $(basename $0 ) GIT-Folder/GIT-Ordner [difftool]          $( tput hpa 75) │
│                                                                           │
│ ${n}e.g. $(basename $0 ) ~/githubaexx/ difftool ${g}      $( tput hpa 75) │
╰───────────────────────────────────────────────────────────────────────────╯

"
}
#tput cup 0 0
#tput ed
if [ $# -lt 1 ]
  then
	  usage;echo
  exit 1
fi
if [ $# -lt 2 ]
  then
	  usage
fi
[ "$2" = "difftool" ] && DIFF=difftool 
ask () {
printf "
╭──── Weiter? / continue? ──────────────────────────────────────────────────╮
│                        [Eingabe/Enter/Return] oder/or [Strg]/[Ctrl] + [C] │
╰───────────────────────────────────────────────────────────────────────────╯"
read
printf "${n}"
}
aexgitdiff () { 
DIFF1="git diff" ; DIFF2="git diff main origin/main"
DIFF1A="git $DIFF" ; DIFF2A="git $DIFF main origin/main"
printf "${n}\r
╭───────────────────────────────────────────────────────────────
╰──── git diff 
$DIFF1 ${n}"
$DIFF1
[ -n "$DIFF" ] && $DIFF1A
printf "${n}\r
╭───────────────────────────────────────────────────────────────
╰──── git diff main origin/main 
$DIFF2 ${n}" 
$DIFF2
[ -n "$DIFF" ] && $DIFF2A
}
STATUS="git status"
FETCH="git fetch"
MERGE="git merge"
ADD="git add ."
gitcommit () {
git commit -a -m "$(date +%Y-%m-%d_%H:%M:%S) $(uname -n) "
}
COMMIT="git commit -a -m \"$(date +%Y-%m-%d_%H:%M:%S) $(uname -n) \""
PUSH="git push"
#
if [ -d $1 ] 
 then
  cd $1
 else
  printf "\n${g} cd $1 => failed , fehlgeschlagen!  ${n}\n\n"
  exit 1
fi
#ask
WAIT 5
#
for repo in `ls`
do
 cd $repo
 printf "${g}\r
╭───────────────────────────────────────────────────────────────────────────╮
│  $repo                                                    $( tput hpa 75) │
╰───────────────────────────────────────────────────────────────────────────╯
${li}
╭───────────────────────────────────────────────────────────────
╰────  Local  <──  REMOTE 
${STATUS}: 
" ; ${STATUS} |sed -e '/^$/d' ; printf "
${FETCH}: 
" ; ${FETCH} ; aexgitdiff ; printf "
"
 if [ -n "$(git status|grep git\ pull )" ]; then
     printf "there are changes";
     printf "${MERGE}:  ${n}"  ; ask ; ${MERGE}
   else
     printf "no changes: pull";
 fi
 printf "${li}\r
╭───────────────────────────────────────────────────────────────
╰───  LOCAL  ──>  Remote 
${STATUS}:
" ; ${STATUS} |sed -e '/^$/d' ; printf "${n}"
 if [ -n "$(git status --porcelain)" ]; then
     echo "there are changes";
     printf "\n${ADD}:  ${n}"  ; ask ; ${ADD}
     printf "\n${COMMIT}:  ${n}" ; ask ; gitcommit
     aexgitdiff
     printf "\n${PUSH}:  ${n}" ; ask ; ${PUSH}
   else
   printf "\nno changes PUSH\n";
 fi
 cd ..
 #countdown g 1 2>/dev/null || sleep 2
done
printf "\n${n}"
#
