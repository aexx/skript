#!/bin/bash
#
# manuell:
# # cd /home/gerdabubi/Bilder/_Handy-Fotos-aus-Dropbox_/ && mv -bv ~/Dropbox/Kamera-Uploads/2018-12* 2018/
#

##sleep 600 ; exit

LETZTESJAHR=$(date --date "1 year ago" +%Y) ; echo LETZTESJAHR=$LETZTESJAHR
JAHR=$(date +%Y)
ORDNERJAHR=/home/gerdabubi/Bilder/_Handy-Fotos-aus-Dropbox_/${JAHR}/
ORDNERLETZTESJAHR=/home/gerdabubi/Bilder/_Handy-Fotos-aus-Dropbox_/${LETZTESJAHR}/
DROPSQUELLE=/home/gerdabubi/Dropbox/Kamera-Uploads/
#
mkdir -pv ${ORDNERJAHR}.comments
mkdir -pv ${ORDNERLETZTESJAHR}.comments
[ -d $ORDNERJAHR ] || echo EXIT
[ -d $ORDNERJAHR ] || break
[ -d $ORDNERLETZTESJAHR ] || echo EXIT
[ -d $ORDNERLETZTESJAHR ] || break
[ -d $DROPSQUELLE ] || echo EXIT
[ -d $DROPSQUELLE ] || exit

du -ms $ORDNERLETZTESJAHR $ORDNERJAHR $DROPSQUELLE 

#find $DROPSQUELLE -maxdepth 1 -mtime +33 -type f -iname "${LETZTESJAHR}*" -exec ls {}  \; >/dev/shm/listeLETZTESJAHR
#find $DROPSQUELLE -maxdepth 1 -mtime +33 -type f -iname "${JAHR}*" -exec ls {}  \; >/dev/shm/listeJAHR
#find $DROPSQUELLE -mtime +160 -type f -iname "*.xml" -exec ls -l {} \;

#find $DROPSQUELLE -maxdepth 1 -mtime +33 -type f -iname "${LETZTESJAHR}*" -exec echo mv -bv {} $ORDNERLETZTESJAHR \;
#find $DROPSQUELLE -maxdepth 1 -mtime +33 -type f -iname "${JAHR}*" -exec echo mv -bv {} $ORDNERJAHR \;
#find ${DROPSQUELLE}.comments -mtime +120 -type f -iname "${LETZTESJAHR}*.xml" -exec echo mv -bv {} ${ORDNERLETZTESJAHR}.comments \;
#find ${DROPSQUELLE}.comments -mtime +120 -type f -iname "${JAHR}*.xml" -exec echo mv -bv {} ${ORDNERJAHR}.comments \;

find $DROPSQUELLE -maxdepth 1 -mtime +33 -type f -iname "${LETZTESJAHR}*" -exec mv -bv {} $ORDNERLETZTESJAHR \;
find $DROPSQUELLE -maxdepth 1 -mtime +33 -type f -iname "${JAHR}*" -exec mv -bv {} $ORDNERJAHR \;
find ${DROPSQUELLE}.comments -mtime +33 -type f -iname "${LETZTESJAHR}*.xml" -exec mv -bv {} ${ORDNERLETZTESJAHR}.comments \;
find ${DROPSQUELLE}.comments -mtime +33 -type f -iname "${JAHR}*.xml" -exec mv -bv {} ${ORDNERJAHR}.comments \;



du -ms $ORDNERLETZTESJAHR $ORDNERJAHR $DROPSQUELLE 

echo "_______ Status: $? _______ "

