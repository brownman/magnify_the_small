#!/bin/bash
# about file:
# plugin:       stop-watch 

#. $TIMERTXT_CFG_FILE

notify-send1 "commitment" "$@"

delay=5
file_locker=/tmp/commitment

stop_watch1(){
    trace "stop_watch1() got: $?"


    local content="$1"

    local res=1
    while :;do
        $(messageYN1 "$date1: $content" "remind?")
        res=$?
        if [ $res -eq 1 ];then
            #( flite "$content" &)
            notify-send1 "$content"
            sleep1 10
        else
            break
        fi

    done


}
#increase_motivation(){
#    local  str=$(random_reason)
#    helper0 "$str"
#    local motivation=$(gxmessage -entrytext "$motivation"  -title 'new reason:' "$str" $GXMESSAGET )
#    helper0 "$motivation" $file_log
#    echo "$motivation"
#}

run(){

    local delay=60 
    local motivation=''
    local cmd=''
    #local str=''
    local res=0



   local  title=$(zenity2  txt priorities )
        delay=$(gxmessage -entrytext "$delay" -title 'enter new' 'delay' $GXMESSAGET)
    #    type1=$(gxmessage -entrytext "$type" -title 'enter new' 'type' $GXMESSAGET)
    #    title=$(gxmessage -entrytext "$title" -title 'enter new' 'title' $GXMESSAGET)
#   local raw=$( zenity --forms --title="Add a progress bar" \
#        --text="supply:" \
#        --separator="," \
#        --add-entry="delay" \
#        --add-entry="mini-task" )
#
#  local delay=$(echo "$raw" | awk -F ',' '{print $1}')
#  local text1=$(echo "$raw" | awk -F ',' '{print $3}')
   #assert_equal_str "$title"
   if [ !  "$delay" ];then
exiting
   fi
local text1="$title" 
        while :;do
            $( messageYN1 "$text1" "reminder" '' 15 )
            res=$?
            if [ $res -eq 1 ];then
                text1=$(gxmessage -entrytext "$text1" -title 'update' 'content' $GXMESSAGET)
                helper0 "$text1" $file_log
                update_logger "reminder" "$text1"
            fi
            helper0 "$text1" $file_log
            cmd="sleep2 '$text1' '$title' '$delay'" 
            eval "$cmd" 

            cmd='increase_motivation'
            motivation=$( every 5 "$cmd")
            helper0 "$motivation" $file_log

        done
    }

    run