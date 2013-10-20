#!/bin/bash
# about file:
# name:        ensure suspension!
# description:   separate the proccess running the suspend.sh
trace 'hi'
notify-send 'ensure suspension'
show_vars
name="$1"

file_locker=/tmp/${name}
delay=5

run(){
sleep1 $timeout_for_suspension 
$tasks_sh $name 
 
}
unlocker
exit
