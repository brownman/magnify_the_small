#!/bin/bash
# about file:
# name:        ensure suspension!
# description:   separate the proccess running the suspend.sh

#notify-send 'ensure suspension'

args=( "$@" )
res=''
notify-send1 'single process' "$@"


run(){
#eval show_args
update_commander

#notify-send3 'who make the loop'

#sleep1 2
#cmd='notify-send1 hi bye'
#cmd='tasker config update_commander'
#decide1 "$cmd"
res=$( tasker "${args[@]}" )
}
run
echo "$res"
