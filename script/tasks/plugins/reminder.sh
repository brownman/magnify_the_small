#!/bin/bash
# about file:
# plugin:       stop-watch 

#. $TIMERTXT_CFG_FILE

notify-send1 "reminder" "$@"

delay=5
file_locker=/tmp/reminder
line="${1:-'goal'}"
stop_watch1(){
    trace "stop_watch1() got: $?"


    local content="$1"

    local res=1
    while :;do
        $(messageYN1 "$date1: $content" "remind?")
        res=$?
        if [ $res -eq $YES ];then
            #( flite "$content" &)
            notify-send1 "$content"
            sleep1 10
        else
            break
        fi

    done


}


run(){
local text11='practice estimation'
    local delay=600 
    local motivation=''
    local cmd=''
    #local str=''
    local res=0

    line=$(gxmessage -entrytext "$line" -title 'enter new' "$text11" $GXMESSAGET)
  if [ "$line" = '' ];then
        exiting
    fi
    local  title="$line"


    local text1="$title" 
    while :;do
        reload_cfg
        $( messageYN1 "$text1" "reminder" '' 35 )
        res=$?
        #assert_equal_str "$res" '1 or 0'
     
        helper0 "$text1" $file_log
        cmd="sleep2 '$text1' '$title' '$delay'" 
        #assert_equal_str "$cmd"
        eval "$cmd" 

   if [[ $res -eq $YES ]];then
            text1=$(gxmessage -entrytext "$text1" -title 'focus' 'update' $GXMESSAGET)
            helper0 "$text1" $file_log
            #update_table logger "$date1" "reminder" "$text1"

        fi

    done
}
update_delay(){
    delay=$(gxmessage -entrytext "$delay" -title 'focus:' 'delay' $GXMESSAGET)

    if [ !  "$delay" ];then
        exiting
    fi
}

unlocker
