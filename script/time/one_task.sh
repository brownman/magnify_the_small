#!/bin/bash
# about file:
# name:        ensure I have only 1 reason to act and not many !



notify-send 'one task:'  "no args"
#$1 $2"
name="one_task"
file_locker=/tmp/$name
delay=6

timeout_for_reasoning=${1:-5}   # Defaults to /tmp dir.
echo "going to run in $timeout_for_reasoning seconds"

#COMMANDER=true

file=$DATA_DIR/tmp/activity.tmp

lines=()
run(){

    local num=$1
    local str=''

    if [ "$num" = '' ];then

        str=$(zenity1 $file)
        local cmd="$tasks_sh $str"
    else
        notify-send "pick line:" "$num"
        file_to_lines "$file"

        local str=${line[@]}

        str="${lines[$num]}"
        local cmd="$tasks_sh $str"
    fi

    commander "$cmd"
}


#unlocker false 
run "$1"
#"$2"

