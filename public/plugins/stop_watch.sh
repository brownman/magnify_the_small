#!/bin/bash
# about file:
# plugin:       stop-watch 

export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
timeout=$1


stop_watch1(){
    echo2 "stop_watch1() got: $1 $2"

local sec=500
local msg="$1"
local msg1=""
echo "sleep ${sec}s"
local title=''

#echo0 "$msg"
  
for (( c=0; c<=$sec; c++ ))
do

#let "m = $c % 60"

    m=$((c%60))
    if [ "$m" -eq 0  ];then
 title="commitment reminder"

   local msg1="$c/$sec:  $msg:"
array_to_buttons "$msg" "$msg1" "$title"

   #gxmessage -title "commitment reminder:" "$msg1" $GXMESSAGET &
    fi
echo -n "$c "
   sleep 1s
done
 
echo0 "$msg"


#ref: http://linux.about.com/od/Bash_Scripting_Solutions/a/Arithmetic-In-Bash.htm
}


stop_watch1 "$1" "$2"

exit 

