#!/bin/bash

pushd `dirname $0` > /dev/null
. $TIMERTXT_CFG_FILE
dir=$TIMER2_DIR

while [ true ];do


reset

    yellow "continue to parent menu ?"


    read answer

    if [ "$answer" = n ]
    then
        exiting
    elif [ "$answer" = y ]
        then
        $PWD/menu.sh

    else
             $timer_sh one_task 

#cd $TIMER2_DIR
#watchr koans-linux.watchr

    fi




done

popd > /dev/null
exit
