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

white ' priorities reminder '
read answer
if  [ "$answer" = 'y' ];then
gedit $DYNAMIC_DIR/wish.txt 
fi



white ' run options.sh ?'
read answer
if  [ "$answer" = 'y' ];then
$PUBLIC_DIR/options.sh
else

echo 'do it manualy !'
fi





