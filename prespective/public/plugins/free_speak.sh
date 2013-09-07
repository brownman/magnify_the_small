#!/bin/bash
# about file:
# desc: talk to yourself and translate it


#. $TIMERTXT_CFG_FILE
memory_game(){
    trace 'memory game'
    local file=$TODAY_DIR/txt/essay.txt

    touch $file
    local str=''
    while :;do
        str=$( gxmessage  -entry -file $file -title 'Memory:' $GXMESSAGET )
        if [ "$str" = '' ];then
            flite 'breaking'
            break
        else
            res=$(spell2 "$str")
            
            update_file $file "$res"
            echo01 "$res"
        fi
    done
}
memory_game
