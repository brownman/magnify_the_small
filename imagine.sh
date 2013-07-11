#!/bin/bash

# this file goal:
# tought-proxy-command
# 
#
#


export workflow_morning="suspend,tasks,blog,readme,record|menus"
export TIMERTXT_CFG_FILE=$PWD/public/cfg/timer.cfg

. $TIMERTXT_CFG_FILE
#echo "$timer_sh"

result=` echo "$workflow_morning" | grep -o "$1" `
if [ "$1" = 'menus' ];then
    $PUBLIC_DIR/menus.sh
elif [ "$1" = 'scrap' ];then
    $TASKS_DIR/scrap.sh "$2" "$3"
else
    if [ "$result" = '' ];then

        echo "$workflow_morning"
        red "invalid task"


    else

        echo -n "choosen task: "
        cyan "$1"
        echo "you are here:"
        echo "$workflow_morning" | grep "$1" 

        $timer_sh "$1" "$2" "$3"

    fi
fi
#random quote:

#echo "evaluate?"
#read answer
#if [ "$answer" = y ];then
#    eval "$1"
#fi
#

#$TASKS_DIR/edit.sh

cat -n $motivations_txt 


exiting

