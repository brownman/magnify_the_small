#!/bin/bash
# about file:
# plugin:        ensure suspension!
# description:   separate the proccess running the suspend.sh
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE

help_options='wait for 3m |  suspend'
help1 "$help_options"
timeout_for_suspension=300


export locker2=/tmp/lock2
if [ -e $locker2 ];then
    red "file exist: $locker2 assume proccess is running"
    echo 'kill process ?'

        pids=`cat $locker2`
          yellow 'removing $locker2'
        `rm $locker2`    
        kill $pids

#    read answer
#    if [ "$answer" = 'y' ];then
#        kill `cat $locker2`
#     
#    fi
#    echo 'remove lock file ?'
#    read answer
#    if [ "$answer" = 'y' ];then
#          yellow 'removing $locker2'
#        `rm $locker2`    
#    fi

else
    green 'create $locker2'
    touch $locker2
    echo $$ >> $locker2

sleep1 $timeout_for_suspension 
$PLUGINS_DIR/suspend.sh


    yellow 'removing $locker2'
    `rm $locker2`

fi


