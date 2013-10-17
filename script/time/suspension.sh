#!/bin/bash
# about file:
# name:        ensure suspension!
# description:   separate the proccess running the suspend.sh
trace 'hi'
notify-send 'ensure suspension'
show_vars
timeout=440

help_options='wait for 3m |  suspend'
help1 "$help_options"

timeout_for_suspension=${1:-$timeout}   # Defaults to /tmp dir.
trace "going to sleep in $timeout_for_suspension seconds"

file_locker='/tmp/suspend'
delay=5
run(){
sleep1 $timeout_for_suspension 
$tasks_sh suspend1
}
unlocker
run
exit
