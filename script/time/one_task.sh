#!/bin/bash
# about file:
# name:        ensure I have only 1 reason to act and not many !



notify_send 'one task:'  "$1"
#file_locker=/tmp/one_task
#delay=6
#add_verbose
    show_env
    
args="$@"
run(){
    local num="$args"
   
        local cmd="tasker task_from hotkeys $num"
        #update_commander
        #commander00 "$cmd"
        res=$(  ${cmd} )
        #sleep1 10
}


run
#echo "$res"
sleep1 10
