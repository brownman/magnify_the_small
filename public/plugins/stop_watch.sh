#!/bin/bash
# about file:
# plugin:       stop-watch 

. $TIMERTXT_CFG_FILE

stop_watch1(){
    echo2 "stop_watch1() got: 1: $1 2: $2 3: $3 4:$4"


    local sec="$1" #500 long
    local every="$2" #60 every 
    local msg="$3" #msg
    local title="$4"

    for (( c=0; c<=$sec; c++ ))
    do

        #let "m = $c % 60"

        m=$((c%every))
        if [[ $m -eq 0  ]];then
            local msg1="$c/$sec:  $msg"

            if [ "$SHOW_BUTTONS" = 'true' ];then
                res=$( string_to_buttons "exit-$msg" "$title" "$msg" "-" )
                #answer=$?

             if [ "$res" = 'exit' ];then
                 echo 'breaking'
               break 
             else
                    echo0 "$res"
             fi

            fi
        fi
        echo -n "$c "
        sleep 1s
    done

    echo0 "$msg"


    
}


reminder1(){

    local msg1=$(grab_it breath)
    local line=$( gxmessage  $GXMESSAGET -entrytext "$msg1" -title 'commitment:' 'add reminder:' )


    if [ "$line" != '' ];then

local long=500
local every=60
local title="commitment reminder"
#        local   long=$( echo $line | awk -F '|' '{print $1}' )
#        local every=$( echo $line | awk -F '|' '{print $2}' )
#        local   msg=$( echo $line | awk -F '|' '{print $3}' )

        stop_watch1 "$long" "$every" "$line" "$title" 
    else
        flite 'no commitments !' 
    fi

}
reminder1 
#exit 

