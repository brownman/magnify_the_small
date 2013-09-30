#!/bin/bash
# about file:
# name:        ensure I have only 1 reason to act and not many !


pushd `dirname $0` > /dev/null

. loader.sh
help_options='wait for 3m |  suspend'
help1 "$help_options"

file_locker=/tmp/commitment

delay=30

timeout_for_reasoning=${1:-5}   # Defaults to /tmp dir.
echo "going to run in $timeout_for_reasoning seconds"
run(){
sleep1 $timeout_for_reasoning
$tasks_sh commitment
}


unlocker 
popd > /dev/null
exit

