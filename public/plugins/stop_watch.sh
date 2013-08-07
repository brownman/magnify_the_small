#!/bin/bash
# about file:
# plugin:       stop-watch 

export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
timeout=$1


stop_watch1(){
echo "stop_watch $1 $2"

local sec="$1"
local msg="$2"
local msg1=""
echo "sleep ${sec}s"

for (( c=1; c<=$sec; c++ ))
do

let "m = $c % 5"

    m=$((c%5))
    if [ "$m" -eq 0  ];then

   local msg1="$c/$sec:  $msg:"
   gxmessage $msg1 $GXMESSAGET
   
   
   
    fi
echo -n "$c "
   sleep 1s
done
 

#http://linux.about.com/od/Bash_Scripting_Solutions/a/Arithmetic-In-Bash.htm
}


stop_watch1 "$1" "$2"
exit 

