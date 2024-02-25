#
if [ $# -lt 1 ]
  then
  echo "EXIT - NO md5-file"
  echo "$0 meine-md5-datei.md5"
  exit 1
fi

[ -f $1 ] || echo "EXIT - NO existing md5-file"
[ -f $1 ] || exit 1

ls *|grep -v ".md5" |grep -v ".sha256" |while read f
do 
  #sleep 1
  [ -f "$f" ] && grep -q $f $1 && ls -la $f 
  [ -f "$f" ] && ( grep -q $f $1 || echo "FILE:  $f  NOT in  $1  => ADD " )
  [ -f "$f" ] && ( grep -q $f $1 || md5sum $f >> $1 )
done
echo "
CHECK:  md5sum -c $1
"
