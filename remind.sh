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

white 'edit wishes ?'
read answer
if  [ "$answer" = 'y' ];then
gedit $DYNAMIC_DIR/wish.txt 
fi



if [ "$1" = "test" ];then
    echo 'test'
    $tasks_sh "$2" "$3" 
elif [ "$1" = "periodic" ];then
    #pids1 "$0" 
    $SCREENS_DIR/periodic.sh
elif [ "$1" = 'menus' ];then
    $PUBLIC_DIR/menus.sh
elif [ "$1" = 'koans' ];then
        $KOANS_DIR/meditate.sh 
else #lazy loading
    cyan 'DO FOR OTHERS IDEA ?'
    read answer
    if  [ "$answer" != '' ];then
        echo "$answer" >> $DYNAMIC_DIR/day/others.txt 
    else
        $tasks_sh suspend
    fi

    cat $CFG_DIR/workflow.txt | head -3
    white 'edit workflow ?'
    read answer
    if  [ "$answer" = 'y' ];then
        gedit $CFG_DIR/workflow.txt
    fi

fi




