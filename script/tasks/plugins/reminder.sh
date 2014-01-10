#!/bin/bash
# about file:
# plugin:       stop-watch 

#. $TIMERTXT_CFG_FILE

notify_send1 "reminder" "$@"

delay=5
file_locker=/tmp/reminder
line=${1:-goal}

#stop_watch1(){
#    trace "stop_watch1() got: $?"
#    local content="$1"
#    local res=1
#    while :;do
#        $(messageYN1 "$date1: $content" "remind?")
#        res=$?
#        if [ $res -eq $YES ];then
#            notify_send1 "$content"
#            sleep1 10
#        else
#            break
#        fi
#    done
#}
#

run(){
    local content='practice estimation'
    local delay=$TIMEOUT_GOAL 
    local cmd=''
    local res=0
    local file=$DATA_DIR/log/reminder.log
    touch $file
    local  title="goal"
    line=$(gxmessage $GXMESSAGET -entrytext "$line" -title 'next goal' -file $file )
    if [ "$line" = '' ];then
        exiting
    else

    local text1="$line" 
tasker update_points "$text1" reminder


            helper0 "$text1" 
            #$file_log
            cmd="sleep2 '$text1' '$title' '$delay'" 
            detach "$cmd" 
    fi
}


#unlocker
run
