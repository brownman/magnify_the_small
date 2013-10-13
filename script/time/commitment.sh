#!/bin/bash
# about file:
# name:        ensure I have only 1 reason to act and not many !



help_options='wait for 3m |  suspend'
help1 "$help_options"
notify-send "$@"

file_locker=/tmp/commitment

delay=30

timeout_for_reasoning=${1:-5}   # Defaults to /tmp dir.
echo "going to run in $timeout_for_reasoning seconds"
run(){

#notify-send "commitment DB:" "$db"
#sleep1 $timeout_for_reasoning
$tasks_sh commitment
#"$db"
}


#unlocker 
run 

