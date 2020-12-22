#!/bin/bash
r="\033[31m"
g="\033[32m"
gr="\033[37m"
b="\033[34m"
hb="\033[36m"
li="\033[35m"
n="\033[m\017"
if [ $# -lt 1 ]
  then
	  printf "\n${g} $0 GIT-Folder/GIT-Ordner [-m]  # -m=difftool (meld) => Use from config ${n}\n\n e.g. $0 ~/githubaexx/ [-m]\n\n"
  exit 1
fi
if [ $# -lt 2 ]
  then
	  printf "\n${g} $0 GIT-Folder/GIT-Ordner [-m]  # -m=difftool (meld) => Use from config ${n}\n\n e.g. $0 ~/githubaexx/ [-m]\n\n"
fi
[ "$2" = "-m" ] && DIFF=difftool 
echo $DIFF
ask () {
printf "${li}"
read -pWeiter?,continue?
printf "${n}"
}
aexgitdiff () { 
DIFF1="git diff" ; DIFF2="git diff main origin/main"
DIFF1A="git $DIFF" ; DIFF2A="git $DIFF main origin/main"
printf "\n${g}====[ $DIFF1 ]====\n${n}"
$DIFF1
[ -n "$DIFF" ] && $DIFF1A
printf "${g}====[ $DIFF2 ]====\n${n}" 
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

if [ -d $1 ] 
 then
  cd $1
 else
  printf "\n${r} cd $1 => failed , fehlgeschlagen!  ${n}\n\n"
  exit 1
fi
ask

for repo in `ls`
do
 cd $repo
 printf "\n${r}========[ $repo ]========\n${n}"
 printf "\n${b}${STATUS}:  ${n}" ; ${STATUS}
# if [ -n "$(git status --porcelain)" ]; then
 if [ -n "$(git status|grep git\ pull )" ]; then
     echo "there are changes";
     aexgitdiff
     printf "\n${b}${FETCH}:  ${n}"  ; ${FETCH}
     aexgitdiff
     printf "\n${b}${MERGE}:  ${n}"  ; ask ; ${MERGE}
   else
     echo "no changes";
 fi
 printf "\n${b}${STATUS}:  ${n}" ; ${STATUS}
 if [ -n "$(git status --porcelain)" ]; then
     echo "there are changes";
     aexgitdiff
     printf "\n${b}${ADD}:  ${n}"  ; ask ; ${ADD}
     printf "\n${b}${COMMIT}:  ${n}" ; ask ; gitcommit
     aexgitdiff
     printf "\n${b}${PUSH}:  ${n}" ; ask ; ${PUSH}
   else
     echo "no changes";
 fi
 cd ..
 countdown g 1 2>/dev/null || sleep 2
done
printf "\n${n}"

