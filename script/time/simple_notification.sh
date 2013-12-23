#!/bin/bash

str="$1"
run(){
local cmd="notify-send1 'simple notification' \"_ $str\""
every "$cmd" 10

    #gxmessage $GXMESSAGET -title 'simple notification' 'hello  world!'
    if [ "$str" = error ];then
        cmd="gxmessage $GXMESSAGET -file $file_error -title 'Errors:'"
        optional "$cmd" 'error.txt' 'error'
    else
        cmd="gedit $KOANS_DIR/about_project.sh"
        optional "$cmd" 'edit about_project.sh' 'error'
    fi


}
run
