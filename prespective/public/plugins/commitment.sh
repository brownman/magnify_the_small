#!/bin/bash
# about file:
# plugin:       stop-watch 

. $TIMERTXT_CFG_FILE
long=500
every=20
show_buttons=$SHOW_BUTTONS
stop_watch1(){
    trace "stop_watch1() got: 1: $1 2: $2 3: $3 4:$4"


    local msg="$1" 
    local title="$2"

    for (( c=0; c<=$long; c++ ))
    do

        #let "m = $c % 60"

        m=$((c%every))
        if [[ $m -eq 0  ]];then
            local msg1="$c/$long:  $msg"

            if [ "$show_buttons" = 'true' ];then
                local res=$( $tasks_sh string_to_buttons step2 "$msg" '-')
                echo0 "$res"

             if [ "$res" = 'Q' ];then
                 reminder1
             fi

            fi
        fi
        echo -n "$c "
        sleep 1s
    done

    echo0 "$msg"


    
}


reminder1(){

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

