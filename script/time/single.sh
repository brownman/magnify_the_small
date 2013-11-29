#!/bin/bash
# about file:
# name:        ensure suspension!
# description:   separate the proccess running the suspend.sh

#notify-send 'ensure suspension'

#assert_equal_str "$@"
#show_vars
name="$1"
shift
args=( "$@" )
#echo "$args"
#exiting

notify-send 'single process' "$name"

#file_locker=/tmp/$name
#delay=5

run(){

cmd="$tasks_sh $name '${args[@]}'"

#cmd="$tasks_sh "$name" "${args[@]}"
#COMMANDER=true
#update_commander
commander "$cmd"
}
run
