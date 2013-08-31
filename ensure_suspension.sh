#!/bin/bash
# about file:
# name:        ensure suspension!
# description:   separate the proccess running the suspend.sh


pushd `dirname $0` > /dev/null
export TIMERTXT_CFG_FILE=$PWD/public/cfg/user.cfg
. $TIMERTXT_CFG_FILE



help_options='wait for 3m |  suspend'
help1 "$help_options"

timeout_for_suspension=${1:-140}   # Defaults to /tmp dir.
echo "going to sleep in $timeout_for_suspension seconds"

export locker2=/tmp/lock2
if [ -e $locker2 ];then
    trace "file exist: $locker2 assume proccess is running"
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
    trace 'create $locker2'
    touch $locker2
    echo $$ >> $locker2

sleep1 $timeout_for_suspension 
#$PLUGINS_DIR/suspend.sh
$tasks_sh suspend1


    yellow 'removing $locker2'
    `rm $locker2`

fi

popd > /dev/null
exit

