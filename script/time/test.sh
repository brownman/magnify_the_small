#!/bin/bash 

#set -o errexit


notify-send1 "Restart Test"
export  COMMANDER=false
#export DEBUG=true
export VERBOSE=false
result_g='equal'

file_test=/tmp/testing
file_locker='/tmp/test'
delay=1

#(tasker motivation &)
plugin(){
    $PLUGINS_DIR/$1.sh "$2" "$3"

}
#cfg(){
#    notify-send1 'cfg test'
#    #local cmd="$@"
#    #assert_equal_str $cmd
#    #local res=$(    commander "$cmd")
#    #echo "$res"
#    local args=( "$@" )
#    #$(show_args "${args[@]}")
#    local res1=$( "${args[@]}")
#    echo "$res1"
#}
snippet(){
    notify-send1 'cfg test'
    local cmd="$@"
    #assert_equal_str $cmd
    local res=$(    commander "$cmd")
    echo "$res"
}
tasks_sh(){
    #assert_equal_str 'a b' 'a b' 'something went wrong'
    #exiting
    #trace "tasks_sh run: $*"
    #tasker "$@" 
    notify-send1 'tasks_sh test'
    #local cmd="$@"
    local args=( "$@" )

    #local cmd=$(echo "tasker ${args[@]}")
    local cmd="tasker ${args[@]}"
    local res1=$( commander "$cmd" )
    echo  "$res1"
}
update_line(){
    IFS='|' read -a args <<< "$line"
    local line1=$(show_args "${args[@]}")
    #line="$line1"
    echo "$line1"
}


test_yaml(){

tasker cow_report koan  
reload_cfg
    trace "tasker"
    #flite 'the next feature'
    local filename=$(get_filename 'txt' 'testing' )
    local line=$(cat $filename | head -1)
    trace   "$filename" 
    trace   "$line" 
    if [ "$line" != '' ];then
        flite "$line"

        notify-send1 'running:' 'test.sh'
        messageYN1 "$line" 'add a soldier ?' 

        local res=$?
        if [ $res -eq 1 ];then

            line=$(  tasker db get koan true false )
#return
#assert_equal_str "$line" 'line'
            local desc=$( echo "$line" | awk -F '|' '{print $1}' )
            local time=$( echo "$line" | awk -F '|' '{print $2}' )
            local route=$( echo "$line" | awk -F '|' '{print $3}' )
            local method=$( echo "$line" | awk -F '|' '{print $4}' )
            local inputs=$( echo "$line" | awk -F '|' '{print $5}' )
            local expect=$( echo "$line" | awk -F '|' '{print $6}' )

#assert_equal_str "$line" 'desc|time|route|method|input|expect?'

            #assert_equal_str "$inputs" "inputs"
            local inputs1=$( echo "$inputs" | sed 's/,/ /g' ) 
route='tasks_sh'
            local cmd=$( echo "$route $method $inputs1" )
            #update_commander
            local result=$(commander "$cmd")
            #remove_commander
            result="$result"

            #assert_not_equal_str "$result" "" 'must not be empty'




local equality=''
if [ "$result" != '' ];then

             equality=$([[ "$result" = "$expect" ]] && echo 'equal' || echo "$result")
        else
            equality='empty'
fi

          
            #tasker db update_table1 koan true true 
            local data="$desc|$time1|$route|$method|$inputs|$expect|$equality"
            
            local ans=$(tasker db set koan false true "$data" )
            if  [ "$equality" ] && [ "$equality" = 'equal' ];then
                notify-send3 'test ok!'
            else
                notify-send1 'google is a friend ?' 'test failed'
                cmd='notify-send3 " must document the new tests"'
                (every "$cmd" 5  &)
            fi

            #local ans=$(tasker db update_table koan true "$desc" "$time1" "$route" "$method" "$inputs1" "$expect" "$equality" )
            #local choose_line=$( tasker db show_selected_table koan )

            echo "$equality"
        else
            notify-send1 'skip' 'pushing test forward'
            tasker motivation smaller &
        fi
    else

        trace  "empty line" 'error parsing'
        echo "empty line"

    fi

#sleep1 5

}

run(){
    result_g=$(test_yaml)


}
#run
unlocker

echo "$result_g"






