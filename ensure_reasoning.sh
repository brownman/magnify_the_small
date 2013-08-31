#!/bin/bash
# about file:
# name:        ensure I have only 1 reason to act and not many !


pushd `dirname $0` > /dev/null
export TIMERTXT_CFG_FILE=$PWD/public/cfg/user.cfg
. $TIMERTXT_CFG_FILE



help_options='wait for 3m |  suspend'
help1 "$help_options"

timeout_for_reasoning=${1:-5}   # Defaults to /tmp dir.
echo "going to run in $timeout_for_reasoning seconds"

export locker3=/tmp/lock3
if [ -e $locker3 ];then
    trace "file exist: $locker3 assume proccess is running"
    echo 'kill process ?'

        pids=`cat $locker3`
          trace 'removing $locker3'
        `rm $locker3`    
        kill $pids



else
    trace 'create $locker3'
    touch $locker3
    echo $$ >> $locker3

sleep1 $timeout_for_reasoning
$tasks_sh commitment 


    trace 'removing $locker3'
    `rm $locker3`

fi

popd > /dev/null
exit

