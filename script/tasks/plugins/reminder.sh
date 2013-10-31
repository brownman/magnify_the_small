#!/bin/bash
# about file:
# plugin:       stop-watch 

#. $TIMERTXT_CFG_FILE

notify-send1 "commitment" "$@"

delay=5
file_locker=/tmp/commitment
#long=$LONG #500
#every=$EVERY #60

stop_watch1(){
    trace "stop_watch1() got: $?"


    local goal="$1"

    local res=1
    while :;do
        $(messageYN1 "$date1: $goal" "remind?")
        res=$?
        if [ $res -eq 1 ];then
            #( flite "$goal" &)
            notify-send1 "$goal"
            sleep1 10
        else
            break
        fi

    done


}
#    for (( c=0; c<=$long; c++ ))
#    do
#
#        #let "m = $c % 60"
#
#        m=$((c%every))
#        if [[ $m -eq 0  ]];then
#            #local title="easiest task:"
#            local buttons1="$c/$long"
#
#            str=$goal
#          
#            messageYN1 "" "continue reminding"
#            res=$?
#            if [ $res -eq 1 ];then
#                notify-send1 'continue to remind' "buttons1"
#            else
#                break
#            fi
#            
#        fi
#       tracen "$c "
#        sleep1 1
#    done
#$(random_command)
#msg1=$(gxmessage $GXMESSAGET -file "$file_now" -title "reminder: $goal"  -entrytext "$str" -buttons "$buttons1" )
#helper0 "$msg1" "$file_now"


run(){



    local title="time frame"
    local motivation=''
    local time_limit=300
    local answer=''
    local str=''
    local res=0
    load goal=''
    local cmd=''



    goal=$(zenity2  txt priorities )
    while :;do


#. $CFG_DIR/vars.cfg

#assert_equal_str "$date2"

        $( messageYN1 "$goal" "reminder" '' 45 )


        #update goal
        res=$?

            #assert_equal_str $res
        if [ $res -eq 1 ];then
            goal=$(gxmessage -entrytext "$goal" -title 'new goal' -file $file_log $GXMESSAGET)
            if [ "$goal" ];then
                cmd="sleep2 $time_limit '$date1-$date2 :: $goal' '$title'" 
                eval "$cmd" &
               update_file $file_log "$date1: $goal"


            fi
        fi


#        random1 2
#        res=$?
#        if [ $res -eq 0 ];then
#
            str=$(random_reason)
            
            echo01 "$str"
            motivation=$(gxmessage -entrytext "$motivation"  -title 'new reason:' "$str" $GXMESSAGET )


#        fi

        helper0 "$goal" $file_log
        sleep1 30
        helper0 "$motivation" $file_log
        sleep1 30
update_logger 'goal' "$goal"
update_logger 'motivation' "$motivation"
    done
}

unlocker
