#!/bin/bash
# about file:
# name:        ensure I have only 1 reason to act and not many !



#help_options=''
#help1 "$help_options"
notify-send 'one task:'  "$1 $2"

#file_locker=/tmp/$1
#commitment

delay=30

timeout_for_reasoning=${1:-5}   # Defaults to /tmp dir.
echo "going to run in $timeout_for_reasoning seconds"
run(){
$tasks_sh "$1" "$2"
}


#unlocker 
run "$1" "$2"
sleep1 10

