#!/bin/bash

# about file:
# first page:
#  - plan your day
#  - childish motivation
#  - connect to earth
#  - do tasks 
#  - learn
#
#


export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
reset 

echo2 "imagine.sh got:  1: $1 2: $2 3: $3"

str=$(higher "$1:")
yellow $str

white 'update report ? '
read answer
if  [ "$answer" = 'y' ];then
gedit $DYNAMIC_DIR/wish.txt & 
gedit $DYNAMIC_DIR/report.txt &
fi

white 'post to blogger/email?'
read answer
if  [ "$answer" = 'y' ];then
$TASKS_DIR/blogger.sh
fi

white 'edit schedules ?'
read answer
if  [ "$answer" = 'y' ];then
echo 'edit.sh'
fi

