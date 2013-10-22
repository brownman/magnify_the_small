#!/bin/bash
# about file:
# name:        ensure I have only 1 reason to act and not many !



notify-send 'one task:'  "$1"
file_locker=/tmp/one_task
delay=6
run(){
    local num="$args"
        local cmd="$tasks_sh task_from hotkeys $num"
        eval "$cmd"
}

args="$1"
run

