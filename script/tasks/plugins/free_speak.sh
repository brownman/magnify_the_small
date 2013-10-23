#!/bin/bash
# about file:
# desc: talk to yourself and translate it


notify-send "free-speak" "$0"
file_essay='x'
subject=${1:-'story_a_day'}

delay=5
file_locker=/tmp/free_speak

export STRING_TO_BUTTONS=false


memory_game(){
    #file_name=${1:-'essay'}
    notify-send 'memory game'
    local file=$file_essay
 

  
    local str=''
    local result=0
    local counter=0 



    while :;do
        let counter+=1
        sleep1 5
        trace "loop $counter"
        str=$(random_grammer) 
        str=$( gxmessage   $GXMESSAGET -entrytext "$str"  -title "$subject" -file "$file")
        helper0 "$str" "$file"
    done
}

run(){


local file=$DATA_DIR/txt/$subject.txt 
touch $file
    if [ -f $file ];then
        notify-send "valid" "$file"
  file_essay=$file
memory_game 
   else
        notify-send "in-valid" "$file"
   fi
}

unlocker
