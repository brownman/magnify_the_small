#!/bin/bash
# about file:
# name:        ensure suspension!
# description:   separate the proccess running the suspend.sh


pushd `dirname $0` > /dev/null


. loader.sh

help_options='wait for 3m |  suspend'
help1 "$help_options"

timeout_for_suspension=${1:-440}   # Defaults to /tmp dir.
echo "going to sleep in $timeout_for_suspension seconds"

file_locker='/tmp/suspend'
delay=60
run(){
sleep1 $timeout_for_suspension 
$tasks_sh suspend1
}
#unlockers
run
popd > /dev/null
exit

