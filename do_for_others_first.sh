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



if [ "$1" = "test" ];then


    echo 'test'

#$tasks_sh  suspend
#$CFG_DIR/examples.sh
#$CFG_DIR/test.sh

    #uml_me
elif [ "$1" = "periodic" ];then

pids1 "$0" 
    $SCREENS_DIR/periodic.sh
    #$workflow
elif [ "$1" = 'menus' ];then
    $PUBLIC_DIR/menus.sh
elif [ "$1" = 'help' ];then
    echo -n 'second arg: '
    cyan 'menus OR periodic'
else
#choose4 $STORY_DIR/exit.txt 
#result=$( exec $PUBLIC_DIR/koan.sh )
#yellow $result

    $PUBLIC_DIR/menus.sh
fi






