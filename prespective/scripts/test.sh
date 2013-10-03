#!/bin/bash

# about file:
# test the first test listen on blank.yaml:testing
#http://www.thegeekstuff.com/2010/10/expect-examples/#more-6218
pushd `dirname $0` > /dev/null

notify-send 'test.sh'
. loader.sh
trace "test.sh got:" " $1 $2 $3"
export VERBOSE=true
#export DEBUG=true
cmd1='$tasks_sh motivation glossary'



#exec "$@" &> /dev/null &
eval "$cmd1" &> /dev/null &

#exiting
result='equal'
file_test=/tmp/testing
file_locker='/tmp/test'
delay=10
#trace "PWD: $PWD"
plugin(){
    $PLUGINS_DIR/$1.sh "$2" "$3"

}
cfg(){
    "$1" "$2" "$3"

}
tasks_sh(){

    trace "tasks_sh run: 1:$1 2:$2 3:$3"
    #notify-send "tasks_sh run: 1:$1 2:$2 3:$3"
    $tasks_sh "$1" "$2" "$3"
}
test_yaml(){
    trace "$tasks_sh"

local filename=$(get_filename1 tmp testing )

    local line=`cat $filename | head -1`





    #breakpoint



    trace   "$filename" 
    trace   "$line" 
    #tracex  'testing.0:' "$line" 
    #notify-send 'result line' "$line" 
    if [ "$line" != '' ];then
        #trace "-$line-"
        #echo "$res"

        route=$( echo "$line" | awk -F '|' '{print $1}' )
        method=$( echo "$line" | awk -F '|' '{print $2}' )
        input=$( echo "$line" | awk -F '|' '{print $3}' )
        expect=$( echo "$line" | awk -F '|' '{print $4}' )
        trace "route: $route"
        local res=$(echo "$input")
        #echo "$res"
        input="$res"



        input1=$( echo "$input" | awk -F ',' '{print $1}' )
        input2=$( echo "$input" | awk -F ',' '{print $2}' )
        #notify-send "$res"
        #echo "$res"
        result=$( eval $route '"$method" "$input1" "$input2"')
        equality=$([[ "$result" = "$expect" ]] && echo 'equal' || echo "result:-$result-")

        echo -n '' > $file_test
        echo "input:   -$input-" >> $file_test
        echo "expect: -$expect-" >> $file_test

        local str=`cat $file_test`

        #(trace "$str" "action: $method " "$equality" true &)
        trace "action: $method " "$str" "$equality"
        echo "$equality"

    else

        trace  "empty line" 'error parsing'
        echo "empty line"

    fi
    #args=$($tasks_sh fetch "$args0")
    #http://tldp.org/LDP/abs/html/comparison-ops.html
    #http://stackoverflow.com/questions/3265803/bash-string-equality
}
#
#smoke(){
#    trace 'do what serial.sh does'
#
#
#    line='show_msg|frame.should|I should do'
#
#    echo "$line "
#    action=$( echo $line | awk -F '|' '{print $1}' )
#    args0=$( echo $line | awk -F '|' '{print $2}' )
#    if [ "$arg0" != '' ];then
#        args=$($tasks_sh fetch "$args0")
#    else
#        args=''
#    fi
#    echo "$args0"
#    exit
#    desc=$( echo $line | awk -F '|' '{print $3}' )
#    notify-send "TASK: $desc" "$args"
#    $tasks_sh "$action" "$args" "$desc" 
##}
#plugin(){
#
#
#    trace "think() got: plugin:$1 method:$2 arg:$3"
#
#    local plugin_name="$1"
#    local cmd=$PLUGINS_DIR/$plugin_name.sh
#    local method="$2"
#    local arg="$3"
#
#    local ans=$($cmd  "$method" "$arg")
#    echo "$ans"
#
#    #result=$?
#    #echo "$result"
#}
#
##test_plugin "$1" "$2" "$3" 
#test_serial(){
#    args0='frame.should'
#    #args=$($PLUGINS_DIR/yaml_parser.sh fetch "$args0")
#    action='show_msg_entry'
#    desc='title abc'
#    $tasks_sh "$action" "$args" "$desc" 
#}
#test_task(){
#    $tasks_sh take_photo
#    echo 'am i dirty?'
##}
#arr=(1 2)
#
#make_array(){
#    #arr=( ${arr[@]/1/} )
#
#    arr=($(echo '1 2 3'))
#}
#show_array1(){
#    echo "before: ${arr[@]}"
#    make_array
#    echo "after: ${arr[@]}"
#}
run(){

 result=$(test_yaml)

#echo "$result"
#flite 'sleep 10 seconds'
#sleep1 4
}
#unlocker test
#run
unlocker
echo "$result"

#echo $(unlocker test)


#eval $1 '"$2" "$3" "$4"'
popd > /dev/null




