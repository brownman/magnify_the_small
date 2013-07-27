#!/bin/bash
# about file:
# mission documentation:
# record your steps being done

export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
file=$DYNAMIC_DIR/report.txt

yellow "record your mission being done:"
gedit $file


cat $file

yellow 'send to blogger ?'
read answer
if [ "$answer" = y ];then

google blogger post $file 
fi




