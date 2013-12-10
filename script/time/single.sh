#!/bin/bash
# about file:
# name:        ensure suspension!
# description:   separate the proccess running the suspend.sh

#notify-send 'ensure suspension'

args=( "$@" )
res=''
notify-send1 'single process' $@""


run(){
#eval show_args
res=$( tasker "${args[@]}" )
}
run
echo "$res"
