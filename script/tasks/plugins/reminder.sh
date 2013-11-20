#!/bin/bash
# about file:
# plugin:       stop-watch 

#. $TIMERTXT_CFG_FILE

notify-send1 "reminder" "$@"

delay=5
file_locker=/tmp/reminder
line="$1"
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



    local  title=''

    if [ "$line" ];then

        title="$line"
    else

        title=$(zenity2  yaml priorities )
    fi

    delay=$(gxmessage -entrytext "$delay" -title 'enter new' 'delay' $GXMESSAGET)

    if [ !  "$delay" ];then
        exiting
    fi
    local text1="$title" 
    while :;do
        reload_cfg
        $( messageYN1 "$text1" "reminder" '' 35 )
        res=$?
        #assert_equal_str "$res" '1 or 0'
        if [[ $res -eq 1 ]];then
            text1=$(gxmessage -entrytext "$text1" -title 'update' 'content' $GXMESSAGET)
            helper0 "$text1" $file_log
            update_table logger "$date1" "reminder" "$text1"

        fi
        helper0 "$text1" $file_log
        cmd="sleep2 '$text1' '$title' '$delay'" 
        #assert_equal_str "$cmd"
        eval "$cmd" 



    done
}

run
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
