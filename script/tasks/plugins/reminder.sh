#!/bin/bash
# about file:
# plugin:       stop-watch 

#. $TIMERTXT_CFG_FILE

notify-send1 "commitment" "$@"

delay=5
file_locker=/tmp/commitment
sleep2(){


    local text="$1"
    local title="$2"
    local sec="$3"
    
    local time2=$(get_time "$sec")

    text="$date1-$time2: $text"
    local num=0

    ( 
    trace "sleep ${sec}s"
    for (( c=1; c<=$sec; c++ ))
    do
        #tracen  "$c "
        num=$((c*100/sec))
        #assert_equal_str "$num"
        echo "$num" ;            sleep 1s
    done
    ) | yad --progress --percentage=10 \
        --progress-text="$text" \
        --title="$title" \
        --sticky --on-top \
        --auto-close

}


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
increase_motivation(){
    local  str=$(random_reason)
    helper0 "$str"
    local motivation=$(gxmessage -entrytext "$motivation"  -title 'new reason:' "$str" $GXMESSAGET )
    helper0 "$motivation" $file_log
    echo "$motivation"
}

run(){

    
    local title="time frame"
    local type1="goal"
    load goal=''
    local motivation=''

    local cmd=''

    #local answer=''
    local str=''
    local res=0



    goal=$(zenity2  txt priorities )
    delay=$(gxmessage -entrytext "$delay" -title 'new' 'delay' $GXMESSAGET)
    title=$(gxmessage -entrytext "$title" -title 'new' 'title' $GXMESSAGET)

    type1=$(gxmessage -entrytext "$type" -title 'new' 'type' $GXMESSAGET)
            
       
    while :;do
        $( messageYN1 "$goal" "reminder" '' 15 )
        res=$?
        if [ $res -eq 1 ];then
            goal=$(gxmessage -entrytext "$goal" -title 'update goal' 'new goal' $GXMESSAGET)
            update_logger "$type1" "$goal"
        fi
        helper0 "$goal" $file_log
        cmd="sleep2 '$goal' '$title' '$delay'" 
        eval "$cmd" 

   cmd='increase_motivation'
   motivation=$( every 5 "$cmd")
        helper0 "$motivation" $file_log
   
    done
}

run
