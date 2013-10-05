#! /usr/bin/env bash

#http://blog.jamesslocum.com/post/61904545275/graphical-user-interfaces-from-a-bash-script-using
    #http://www.tldp.org/LDP/abs/html/testbranch.html#MATCHSTRING
#http://www.tldp.org/LDP/abs/html/internal.html#ARRCHOICE

#result=1

#loop(){
##local str=''
##local res=0
#while [[ $result -eq $SUCCESS ]];do
##while :;do
#
# result=$?
# notify-send "result" "$result"
# 
#done
#
#
#}
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
    if [ "$COMMANDER" = true ];then

    #local res=$(commander "$command")
commander "$command"
    else
        eval "$command"
    fi

    #local num=$?
}

load(){
    notify-send 'reload cfg'
#. $PWD/script/loader.sh

#export COMMANDER=false
}

first_dialog(){
#'what do you want to do next ?'
local str=''
local res=0


while [ "$str" != 'exit' ];do

    str=$(gxmessage -entrytext "$str" -title 'simplest log'  -file $file_log )

    if [ "$str" != '' ];then
      
    is_command "$str"
    res=$?


        if [[ $res -eq 1 ]];then

        update_file $file_log "$str"
        try "$str"
        else
        update_file $file_log "+$str"
        fi

    fi


done

}

first_dialog

