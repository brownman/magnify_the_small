#!/bin/bash
# about file:
# name:        ensure I have only 1 reason to act and not many !



notify-send 'one task:'  "no args"
file_locker=/tmp/one_task
delay=6
#help="number should be "

timeout_for_reasoning=${1:-5}   # Defaults to /tmp dir.
echo "going to run in $timeout_for_reasoning seconds"
#COMMANDER=true

file=$DATA_DIR/tmp/activity.tmp
#file1=$DATA_DIR/tmp/background.tmp
#$(gxmessage -file $file $GXMESSAGET -iconic) &
mantion_file $file
lines=()
run(){

    local num="$args"
    local str=''
    local str1=''
    local str=''

        str=$(zenity1 $file)
        local cmd="$tasks_sh $str"
    #$(messageYN1 "_${cmd}_"  "2nd param :")
    #$?
    local res=1


    if [[ $res -eq 1 ]];then
        notify-send "continue!"
        eval "$cmd"
    else

        notify-send "cancel!"

        #breakpoint
    fi

}

args="$1"
#unlocker 
run
exit
#"$1"
#"$2"

