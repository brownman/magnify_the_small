#!/bin/bash

# about file:
# tought-proxy-command
# 
#
#
#. $TIMERTXT_CFG_FILE
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
reset 
echo2 "imagine.sh got:  1: $1 2: $2 3: $3"

profit(){
    cyan 'are you creative now ?'
    ls -1 $STORY_DIR
    read answer

    file=$STORY_DIR/${answer}.txt

    files=$(ls  $file 2> /dev/null )

    if [[  "$files"  ]]
    then
        green '...'
        $SCREENS_DIR/motivation.sh "$answer"
    else
        red 'file not found'
    fi
    sleep1 1

}




if [ "$1" = "periodic" ];then
    $SCREENS_DIR/periodic.sh
else
    profit
    $PUBLIC_DIR/menus.sh
fi





