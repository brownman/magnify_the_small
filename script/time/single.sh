#!/bin/bash
# about file:
# name:        ensure suspension!
# description:   separate the proccess running the suspend.sh

#notify-send 'ensure suspension'

#assert_equal_str "$@"
#show_vars
#name="$1"
#shift
args=( "$@" )
#echo "$args"
#exiting

notify-send 'single process' "$name"

#file_locker=/tmp/$name
#delay=5

run(){

show_args
cmd="tasker ${args[@]}"

#cmd="tasker "$name" "${args[@]}"
#COMMANDER=true
#update_commander
res=$( commander "$cmd" )
#remove_commander
}
run
echo "$res"
