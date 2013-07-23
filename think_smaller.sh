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
#. $TIMERTXT_CFG_FILEadd_line


export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
reset 

echo2 "imagine.sh got:  1: $1 2: $2 3: $3"

str=$(higher "$1:")
yellow $str



if [ "$1" = "test" ];then
    echo 'test'
    $tasks_sh  suspend
elif [ "$1" = "periodic" ];then
    pids1 "$0" 
    $SCREENS_DIR/periodic.sh
elif [ "$1" = 'menus' ];then
    $PUBLIC_DIR/menus.sh
else #lazy loading
    cyan 'DO FOR OTHERS IDEA ?'
    read answer
    if  [ "$answer" != '' ];then
        echo "$answer" >> others.txt 
    else
        $tasks_sh suspend
    fi

    cat $CFG_DIR/workflow.txt
    white 'edit workflow ?'
    read answer
    if  [ "$answer" = 'y' ];then
        gedit $CFG_DIR/workflow.txt
    fi

    white 'run periodic timer ?'
    read answer
    if  [ "$answer" = 'y' ];then
        $SCREENS_DIR/periodic.sh
        $KOANS_DIR/meditate.sh 
    fi
fi




