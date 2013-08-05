#!/bin/bash

# about file:
# test first!
#
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
reset 

export GUI='true'
echo 'test.sh !'
#result=$()
result1=$( messageYN "title0" "str 01 ")
#echo "echoiiing: $?"
#result1="$?"
#`echo $?`
echo -n "result1: "
cyan "$result1"
exit

