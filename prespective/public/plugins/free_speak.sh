#!/bin/bash
# about file:
# desc: talk to yourself and translate it


#. $TIMERTXT_CFG_FILE

memory_game(){
    file_name=${1:-'essay'}
    trace 'memory game'
    mkdir -p $CFG_DIR/essay
    local file=$CFG_DIR/essay/$file_name.txt
    touch $file
    local str=''
    while :;do
        str=$( gxmessage  -entry -file $file -title 'Memory:' $GXMESSAGE0 )
        if [ "$str" = '' ];then
            flite 'breaking'
            break
        else
            res=$(spell2 "$str")
            
            update_file $file "$res"
            (  echo01 "$res" &)
        fi
    done
    
}
memory_game "$1"
