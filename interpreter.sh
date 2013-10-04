#! /usr/bin/env bash

#http://blog.jamesslocum.com/post/61904545275/graphical-user-interfaces-from-a-bash-script-using
    #http://www.tldp.org/LDP/abs/html/testbranch.html#MATCHSTRING
#http://www.tldp.org/LDP/abs/html/internal.html#ARRCHOICE

file_log=/tmp/log
. ./script/loader.sh

is_command(){
local str="$1"
case "$str" in
  !*) return $SUCCESS;;  # Begins with a letter?
  *) return $FAILURE;;
esac
}

try(){
local res=$(    remove_char "$1" "!")
    local command="$res"
    local res=$(eval "$command")
    local num=$?
    notify-send "$command:" "$num : $res"
}



first_dialog(){
#'what do you want to do next ?'
local str=''
#while [ "$str" != 'exit' ]
#do
str=$(gxmessage -entrytext "$str" -title 'simplest log'  -file $file_log )
is_command "$str"
notify-send $?
local res="$str"
#echo  "$str" >> $file_log
update_file $file_log "$str"

if [[ $res -eq 1 ]];then
    try "$str"
fi

#done
}


run(){
    first_dialog
}

run
