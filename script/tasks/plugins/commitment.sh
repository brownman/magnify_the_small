#!/bin/bash
# about file:
# plugin:       stop-watch 

#. $TIMERTXT_CFG_FILE
long=500
every=60
show_buttons=$SHOW_BUTTONS
stop_watch1(){
    trace "stop_watch1() got: $?"
    #1: $1 2: $2 " #3: $3 4:$4"


    local msg="$1" 
    local title="$2"


     local msg1="$msg" 
    for (( c=0; c<=$long; c++ ))
    do

        #let "m = $c % 60"

        m=$((c%every))
        if [[ $m -eq 0  ]];then
            #local title="easiest task:"
            local buttons1="$c/$long"


            msg1=$(gxmessage $GXMESSAGET -file "$file_now" -title "$title" -entrytext "$msg1")
            helper0 "$msg1" "$file_now"
        fi
        echo -n "$c "
        sleep 1s
    done

    #echo0 "$msg"


    
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
commit1(){
local task="$1"
#variable=$(zenity --entry --text "Please enter some text" --entry-text "Hello world!")

  local msg=$(zenity --entry --title="Commitment:" --text="Add new task" \
      --entry-text "$task" ) 
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

         local title="($long/$every)-$msg"
        stop_watch1  "$msg" "$title" 
}

pick_one_task(){
local file=$(get_filename1 tmp tasks)
local res=$(zenity1 $file)
#gxmessage "$res" $GXMESSAGET
commit1 "$res"
}

#reminder1 "$1" 
#commit1 
pick_one_task
#"$1"
#exit 

