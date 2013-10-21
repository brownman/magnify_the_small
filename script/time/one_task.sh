#!/bin/bash
# about file:
# name:        ensure I have only 1 reason to act and not many !



notify-send 'one task:'  "$1"
file_locker=/tmp/one_task
delay=6
#help="number should be "

timeout_for_reasoning=${1:-5}   # Defaults to /tmp dir.
echo "going to run in $timeout_for_reasoning seconds"
#COMMANDER=true

#file=$DATA_DIR/tmp/activity.tmp
#file1=$DATA_DIR/tmp/background.tmp
#$(gxmessage -file $file $GXMESSAGET -iconic) &
mantion_file $file
#lines=()
run(){

    local num="$args"
    notify-send "$num"
    local str=''
    local str1=''
    local str=''

        #str=$(zenity1 $file)
        local cmd="$tasks_sh task_from activity $num"



        eval "$cmd"

}

args="$1"
#unlocker 
run
exit
#"$1"
#"$2"

