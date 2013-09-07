#!/bin/bash

# about file:
# test first!
#

pushd `dirname $0` > /dev/null
export TIMERTXT_CFG_FILE=public/cfg/user.cfg

. $TIMERTXT_CFG_FILE
#remove_trailing " abc "
export DEBUG='true'

     file_test=/tmp/testing

#trace "PWD: $PWD"
plugin(){
$PLUGINS_DIR/$1.sh "$2" "$3"

}
cfg(){
 "$1" "$2" "$3"

}
tasks_sh(){
    trace "tasks_sh run: 1:$1 2:$2 3:$3"
$tasks_sh "$1" "$2" "$3"
}
test_yaml(){

local line=$( $tasks_sh fetch 'frame.testing')
#tracex "-$line-"
echo "$res"

route=$( echo "$line" | awk -F '|' '{print $1}' )
method=$( echo "$line" | awk -F '|' '{print $2}' )
input=$( echo "$line" | awk -F '|' '{print $3}' )
expect=$( echo "$line" | awk -F '|' '{print $4}' )
result=$(eval $route '"$method" "$input"')
equality=$([[ "$result" = "$expect" ]] && echo equal || echo "result:-$result-")

echo -n '' > $file_test
echo "input:   -$input-" >> $file_test
echo "expect: -$expect-" >> $file_test

local str=`cat $file_test`

#tracex "$str" "action: $method " "$equality"
trace "$str" "action: $method " "$equality"
echo "$equality"
        #args=$($tasks_sh fetch "$args0")
#http://tldp.org/LDP/abs/html/comparison-ops.html
#http://stackoverflow.com/questions/3265803/bash-string-equality
}


test_plugin(){


    trace "think() got: plugin:$1 method:$2 arg:$3"

    local plugin_name="$1"
local cmd=$PLUGINS_DIR/$plugin_name.sh
    local method="$2"
    local arg="$3"
    
local ans=$($cmd  "$method" "$arg")
    echo "$ans"
    
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
arr=(1 2)

make_array(){
#arr=( ${arr[@]/1/} )

arr=($(echo '1 2 3'))
}
show_array1(){
echo "before: ${arr[@]}"
make_array
echo "after: ${arr[@]}"
}
#show_array1

#test_plugin "$1" "$2" "$3"
#cd testing/python2

#./testing/python2/run.sh
eval $1 '"$2" "$3" "$4"'
popd > /dev/null




