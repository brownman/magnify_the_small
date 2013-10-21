#!/bin/bash
# about file:
# plugin:       stop-watch 

#. $TIMERTXT_CFG_FILE
notify-send "$@"
delay=5
file_locker=/tmp/commitment
long=$LONG #500
every=$EVERY #60
show_buttons=$SHOW_BUTTONS
stop_watch1(){
    trace "stop_watch1() got: $?"
    #1: $1 2: $2 " #3: $3 4:$4"

flite 'I am your robot'
    #local msg="$1" 
    local goal="$1"

local str=''
    local msg1=""
#$msg" 
    for (( c=0; c<=$long; c++ ))
    do

        #let "m = $c % 60"

        m=$((c%every))
        if [[ $m -eq 0  ]];then
            #local title="easiest task:"
            local buttons1="$c/$long"

            str=$(random_command)

            msg1=$(gxmessage $GXMESSAGET -file "$file_now" -title "reminder: $goal"  -entrytext "$str" -buttons "$buttons1" )
            helper0 "$msg1" "$file_now"
        fi
       tracen "$c "
        sleep1 1
    done
}


reminder1(){
    trace "reminder got: $1"


    local msg="commitment in time"
    #iemtell the robot"

    local title="higher-self"
    local entry1="$1"
    local line=$( gxmessage  $GXMESSAGET -entrytext "$entry1" -title "$title" "$msg" )


    if [ "$line" != '' ];then


        #local title="commitment reminder"
        #        local   long=$( echo $line | awk -F '|' '{print $1}' )
        #        local every=$( echo $line | awk -F '|' '{print $2}' )
        #        local   msg=$( echo $line | awk -F '|' '{print $3}' )

        stop_watch1  "$line" "$title" 
    else

        flite 'no commitments !' 
        $tasks_sh motivation glossary

    fi

}
update_timing(){
    local line=$(zenity --forms --title="Commitment:" --text="snoozing:" \
        --add-entry="long:" \
        --add-entry="every:" \
        )

    local tmp=$( echo $line | awk -F '|' '{print $2}' )
    if [ "$tmp" != '' ];then
        long=$tmp
    fi
    local tmp=$( echo $line | awk -F '|' '{print $3}' )
    if [ "$tmp" != '' ];then
        every=$tmp
    fi
}

commit1(){
    local file=$DATA_DIR/tmp/currently.tmp
    local goal=$(zenity1 $file)
    stop_watch1  "$goal" 
}

run(){

commit1
}
unlocker

