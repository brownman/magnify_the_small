#!/bin/bash
# about file:
# plugin:       stop-watch 

#. $TIMERTXT_CFG_FILE
long=500
every=60
show_buttons=$SHOW_BUTTONS
stop_watch1(){
    trace "stop_watch1() got: 1: $1 2: $2 3: $3 4:$4"


    local msg="$1" 
    local title="$2"

     local msg1="$msg" 
    for (( c=0; c<=$long; c++ ))
    do

        #let "m = $c % 60"

        m=$((c%every))
        if [[ $m -eq 0  ]];then
            local title="commitment"
            local buttons1="$c/$long"


     msg1=$(gxmessage $GXMESSAGET -file "$file_now" -title "higher self:" -entrytext "I can")
     local line="$date1: $msg1"
     notify-send "$line"
update_file  "$file_now" "$line" 
echo01 "$msg1"
#
#            if [ "$show_buttons" = 'true' ];then
#                local res=$( $tasks_sh string_to_buttons "$msg" '-')
#
#
#             if [ "$res" = 'Q' ];then
#                 reminder1
#             else
#notify-send 'reminder got nothing'
#                echo0 "$res"
#             fi
#
#            fi
        fi
        echo -n "$c "
        sleep 1s
    done

    echo0 "$msg"


    
}


reminder1(){
trace "reminder got: $1"
    local line=$( gxmessage  $GXMESSAGET -entrytext "$1" -title 'commitment:' 'add reminder:' )


    if [ "$line" != '' ];then


local title="commitment reminder"
#        local   long=$( echo $line | awk -F '|' '{print $1}' )
#        local every=$( echo $line | awk -F '|' '{print $2}' )
#        local   msg=$( echo $line | awk -F '|' '{print $3}' )

        stop_watch1  "$line" "$title" 
    else

        flite 'no commitments !' 
        $tasks_sh motivation glossary

    fi

}
reminder1 "$1" 
#exit 

