#!/bin/bash
# about file:
# name:        ensure I have only 1 reason to act and not many !



#help_options=''
#help1 "$help_options"
notify-send 'one task:'  "no args"
#$1 $2"

#file_locker=/tmp/$1
#commitment

delay=30

timeout_for_reasoning=${1:-5}   # Defaults to /tmp dir.
echo "going to run in $timeout_for_reasoning seconds"
run(){

    #unlocker 
    if [ "$1" != '' ];then

        local cmd="$tasks_sh $1 $2"

        #COMMANDER=true
    else
        local   file=$DATA_DIR/tmp/activity.tmp
        local str=$(zenity1 $file)

        local cmd="$tasks_sh $str"
    fi


    commander "$cmd"
    #1" "$2"
}



run "$1" "$2"
sleep1 10

