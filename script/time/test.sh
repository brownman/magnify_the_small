#!/bin/bash 

#set -o errexit


notify-send1 "Restart Test"
export  COMMANDER=false
export DEBUG=true
export VERBOSE=false
result_g='equal'

file_test=/tmp/testing
file_locker='/tmp/test'
delay=1

#($tasks_sh motivation &)
plugin(){
    $PLUGINS_DIR/$1.sh "$2" "$3"

}
cfg(){
    notify-send1 'cfg test'
    local cmd="$@"
    #assert_equal_str $cmd
    local res=$(    commander "$cmd")
    echo "$res"
}
task(){
    #assert_equal_str 'a b' 'a b' 'something went wrong'
    #exiting
    #trace "tasks_sh run: $*"
    #$tasks_sh "$@" 
    notify-send1 'tasks_sh test'
    #local cmd="$@"
    local args=( "$@" )

    #local cmd=$(echo "$tasks_sh ${args[@]}")
    local cmd="$tasks_sh ${args[@]}"
    #COMMANDER=true
    local res1=$( commander "$cmd" )
    echo  "$res1"
}
test_yaml(){
    trace "$tasks_sh"

    local filename=$(get_filename1 tmp testing )

    local line=$(cat $filename | head -1)
    #breakpoint
    trace   "$filename" 
    trace   "$line" 
    #tracex  'testing.0:' "$line" 
    if [ "$line" != '' ];then
        local route=$( echo "$line" | awk -F '|' '{print $1}' )
        local method=$( echo "$line" | awk -F '|' '{print $2}' )
        local input=$( echo "$line" | awk -F '|' '{print $3}' )
        local expect=$( echo "$line" | awk -F '|' '{print $4}' )

        #trace "route: $route"
        #local res=$(echo "$input")
        #res=$(ls -l  $res)
        #assert_equal_str "$res"
        #echo "$res"
        #input="$res"



        local input1=$( echo "$input" | sed 's/,/ /g' ) 
        #awk -F ',' '{print $1}' )
        #input2=$( echo "$input" | awk -F ',' '{print $2}' )
        #echo "$res"
        ################### eval 
        local cmd=$( echo "$route $method $input1" )
        #COMMANDER=true
        local result=$(commander "$cmd")

        #assert_not_equal_str "$result" "" 'must not be empty'





        local equality=$([[ "$result" = "$expect" ]] && echo 'equal' || echo "-$result-!=$expect")

        $(update_table koan "$route" "$method" "$input1" "$expect" "$equality" )
        if [ "$equality" = 'equal' ];then
            notify-send3 'test ok!'

            $( show_selected_table koan )
        else
            notify-send1 'test failed'
            cmd="gxmessage $GXMESSAGET 'google is a friend' -entry;xargs google-chrome"
            (every "$cmd" 5  &)
        fi


        #
        #        local equality=$([[ "$result" = "$expect" ]] && echo 'equal' || echo "result:-$result-")
        #
        #        echo -n '' > $file_test
        #        echo "input:   -$input-" >> $file_test
        #        echo "expect: -$expect-" >> $file_test
        #
        #        local str=$(cat $file_test)
        #
        #        #(trace "$str" "action: $method " "$equality" true &)
        #        trace "action: $method $str $equality"
        echo "$equality"
    else

        trace  "empty line" 'error parsing'
        echo "empty line"

    fi

}

run(){
    result_g=$(test_yaml)


}
#run
unlocker

echo "$result_g"






