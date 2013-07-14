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
#. $TIMERTXT_CFG_FILE
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
reset 
echo2 "imagine.sh got:  1: $1 2: $2 3: $3"

sky(){
    cyan 'have profit !'
    yellow 'imagine an ideal day !'
    $SCREENS_DIR/motivation.sh 
}

plan(){

    cyan "guidance ?"
    read answer
    if [ "$answer" = y ];then
        sky
    fi
    cyan "creative ?"
    read answer
    if [ "$answer" = y ];then
        sky
    fi
    cyan "update project's goals ?"
    read answer
    if [ "$answer" = y ];then
        gedit $readme_md 
    fi

    cyan "current workflow:"
    echo "$workflow"
    echo 'execute the workflow ?'
    read answer
    if [ "$answer" = y ];then
        xterm -e "$SCREENS_DIR/periodic.sh \"$workflow\""
    fi

      cyan "continue to manu ?"
    read answer
    if [ "$answer" = y ];then

    $PUBLIC_DIR/menus.sh
    fi
}


if [ "$1" = "periodic" ];then
    $SCREENS_DIR/periodic.sh $workflow
else

    plan


fi





