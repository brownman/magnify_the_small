#!/bin/bash

# about file:
# test first!
#

pushd `dirname $0` > /dev/null
export TIMERTXT_CFG_FILE=public/cfg/user.cfg

export DEBUG='true'
. $TIMERTXT_CFG_FILE

#trace "PWD: $PWD"



test_plugin(){


    trace "think() got: plugin:$1 method:$2 arg:$3"

    local plugin_name="$1"
local cmd=$PLUGINS_DIR/$plugin_name.sh
    local method="$2"
    local arg="$3"
    
local ans=$($cmd  "$method" "$arg")
    echo "ans: $ans"
    
    #result=$?
    #echo "$result"
}

#test_plugin "$1" "$2" "$3" 
test_serial(){
args0='frame.should'
args=$($PLUGINS_DIR/yaml_parser.sh fetch "$args0")
action='show_msg_entry'
desc='title abc'


      $tasks_sh "$action" "$args" "$desc" 

}
test_task(){

            $tasks_sh take_photo
            echo 'am i dirty?'
}
test_task
popd > /dev/null


