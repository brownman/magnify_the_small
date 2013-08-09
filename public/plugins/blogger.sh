#!/bin/bash
# about file:
# mission documentation:
# record your steps being done

export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE

file=$TODAY_DIR/yaml/report.yaml
file1=$TODAY_DIR/yaml/achivements.yaml

yellow "record your mission being done:"

gedit $file & 
gedit $file1  


yellow "send $file1 to blogger ?"
read answer
if [ "$answer" = y ];then
google blogger post $file1 
fi

yellow "send $file to blogger ?"
read answer
if [ "$answer" = y ];then
google blogger post $file 
fi


yellow 'send as email ?'
read answer
if [ "$answer" = y ];then

$TASKS_DIR/mail.sh
$TASKS_DIR/mail2.sh

fi

yellow 'upload new video to youtube ?'
read answer
if [ "$answer" = y ];then
url1=https://www.youtube.com/upload
chromium-browser $url1
fi

