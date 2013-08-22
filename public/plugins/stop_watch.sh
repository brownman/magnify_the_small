#!/bin/bash
# about file:
# plugin:       stop-watch 

. $TIMERTXT_CFG_FILE
timeout=$1

stop_watch1(){
    echo2 "stop_watch1() got: $1 $2 $3"


    local sec="$1" #500 long
    local every="$2" #60 every 
    local msg="$3" #msg
    local msg1=""
    #echo "sleep ${sec}s"
    local title=''

    #echo0 "$msg"

    for (( c=0; c<=$sec; c++ ))
    do

        #let "m = $c % 60"

        m=$((c%every))
        if [ "$m" -eq 0  ];then
            title="commitment reminder"

            local msg1="$c/$sec:  $msg"

            if [ "$SHOW_BUTTONS" = 'true' ];then
                res=$( string_to_buttons "exit - $msg" "$title" "translate:" '-' )
                answer=$?

                if [[ $answer -eq 0 ]];then
                   break 
                else
                    echo0 "$res"
                fi
            else
                string_to_buttons 'exit ok'  "commitment reminder:" "$msg1"
                answer=$?

                if [[ $answer -eq 0 ]];then
                   break 
                else
                    echo 'go on'
                fi

            fi



        fi
        echo -n "$c "
        sleep 1s
    done

    echo0 "$msg"


    #ref: http://linux.about.com/od/Bash_Scripting_Solutions/a/Arithmetic-In-Bash.htm
}

reminder1(){
    local line=$( gxmessage -entrytext  '500|60|commitment:' -title 'commitment' '5 minutes for the next step:' $GXMESSAGET  )

    if [ "$line" != '' ];then
        local   long=$( echo $line | awk -F '|' '{print $1}' )
        local every=$( echo $line | awk -F '|' '{print $2}' )
        local   msg=$( echo $line | awk -F '|' '{print $3}' )

        stop_watch1 "$long" "$every" "$msg" 
    else
        flite 'no commitments !' 
    fi
}
reminder1 
#exit 

