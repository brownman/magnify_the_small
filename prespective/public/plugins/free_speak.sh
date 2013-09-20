#!/bin/bash
# about file:
# desc: talk to yourself and translate it
#mkdir -p $CFG_DIR/essay
file_essay='x'


memory_game(){
    file_name=${1:-'essay'}
    trace 'memory game'

    dir=$CFG_DIR/essay/$LANG_DEFAULT
    mkdir -p $dir
    local file=$dir/$file_essay.txt
    touch $file
    local str=''
    while :;do
        str=$( gxmessage  -entry -file $file -title "Memory: $file_essay" $GXMESSAGE0 )
        if [ "$str" = '' ];then
            local line1=$(cat $file | head -1)
            echo01 "$line1" &
        elif [ "$str" = 'exit' ];then
            flite 'breaking'
            break
        elif [ "$str" = 'learn_langs' ];then
               $tasks_sh learn_langs & 
        else
            res=$(spell2 "$str")
           if [ "$res" = 'error' ];then
               trace 'error spelling'
         
           else
              update_file $file "$res"
            (  echo01 "$res" &)
           fi
           
          
        fi
    done
    
}
change_language(){

local str=$( gxmessage  -entrytext "$LANG_DEFAULT" -title 'change language:' $GXMESSAGE0 'pick a language:' )
if [ "$str" = '' ];then
    flite 'exiting'
    exiting
fi
export LANG_DEFAULT="$str"
local str1=$(higher "$LANG_DEFAULT")
export LANG_NAME="$str1"
#echo01 'dog'
#echo "$str1"

}

change_filename(){
        str=$( gxmessage  -entrytext "person_name" -title 'change file_name:' $GXMESSAGE0 'new filename:' )
if [ "$str" = '' ];then
    flite 'exiting'
    exiting
fi
        file_essay="$str"
        #echo "$file_essay"
}


change_filename
change_language
memory_game 
