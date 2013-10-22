#!/bin/bash
# about file:
# name:        ensure suspension!
# description:   separate the proccess running the suspend.sh

#notify-send 'ensure suspension'
show_vars
name="$1"

notify-send 'single process' "$name"

file_locker=/tmp/$name
delay=5

run(){
$tasks_sh $name
}
unlocker
