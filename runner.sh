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


. $TIMERTXT_CFG_FILE
        $PWD/menu.sh

    else

. $TIMERTXT_CFG_FILE
green 'run series of tasks in circle'
        if [ -t 0 ]; then stty -echo -icanon time 0 min 0; fi

            count=0
            keypress=''
            while [ "x$keypress" = "x" ]; do


                let count+=1
                echo -ne $count'\r'
                read keypress

##############################################################
                 $dir/timer.sh series "$SERIES1" 
##############################################################
                sleep1 10
            done

            if [ -t 0 ]; then stty sane; fi

            echo "You pressed '$keypress' after $count loop iterations"
            echo "Thanks for using this script."
            exit 0



    fi




done

popd > /dev/null
exit
