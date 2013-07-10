#!/bin/bash

# this file goal:
# tought-proxy-command
# 
#
#


file=$PWD/public/cfg/timer.cfg
#echo "$file"
. $file


thought="$1"
command="$2"
answer="$command # $tought"


message1() {
cyan "~ Dream First ~"
white "Imagine easiness.."
white "only then.."
sleep1 3
yellow " ACT !"
update_file  $repl_sh "$answer"

}

reset
if [ "$thought" = '' ];then
    cyan "Help:"
    white  "please supply: 'command' 'thought' ''"
    exit 1
else
    message1
    eval "$answer"
    red "$?"
    green "try harder my lad !"
fi


blue "should I record you ?"

