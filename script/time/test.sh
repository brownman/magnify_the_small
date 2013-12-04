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
    #local cmd="$@"
    #assert_equal_str $cmd
    #local res=$(    commander "$cmd")
    #echo "$res"
    local args=( "$@" )
    #$(show_args "${args[@]}")
    local res1=$( "${args[@]}")
    echo "$res1"
}
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
    #$tasks_sh "$@" 
    notify-send1 'tasks_sh test'
    #local cmd="$@"
    local args=( "$@" )

    #local cmd=$(echo "$tasks_sh ${args[@]}")
    local cmd="$tasks_sh ${args[@]}"
    local res1=$( commander "$cmd" )
    echo  "$res1"
}
update_line(){
    IFS='|' read -a args <<< "$line"
    local line1=$(show_args2 "${args[@]}")
    #line="$line1"
    echo "$line1"
}


test_yaml(){
    trace "$tasks_sh"
    flite 'the next feature'
    local filename=$(get_filename 'txt' 'testing' )
    local line=$(cat $filename | head -1)
tasker cow_report koan &
tasker motivation koan &
    trace   "$filename" 
    trace   "$line" 
    if [ "$line" != '' ];then


        local desc=$( echo "$line" | awk -F '|' '{print $1}' )


        flite "$desc"
        messageYN1 "$desc" 'recent koan' 
        local res=$?
        if [ $res -eq 1 ];then




            line=$(         update_line "$line" )
            local desc=$( echo "$line" | awk -F '|' '{print $1}' )
            local route=$( echo "$line" | awk -F '|' '{print $2}' )
            local method=$( echo "$line" | awk -F '|' '{print $3}' )
            local inputs=$( echo "$line" | awk -F '|' '{print $4}' )
            local expect=$( echo "$line" | awk -F '|' '{print $5}' )


      


            local inputs1=$( echo "$inputs" | sed 's/,/ /g' ) 

            local cmd=$( echo "$route $method $inputs1" )
            #update_commander
            local result=$(commander "$cmd")
            result="$result"

            #assert_not_equal_str "$result" "" 'must not be empty'






            local equality=$([[ "$result" = "$expect" ]] && echo 'equal' || echo "$result")
          

            if [ "$equality" = 'equal' ];then
                notify-send3 'test ok!'
            else
                notify-send1 'google is a friend ?'
                cmd='notify-send3 " must document the new tests"'
                (every "$cmd" 5  &)
            fi

            local ans=$($tasks_sh db update_table koan true "$desc" "$time1" "$route" "$method" "$inputs1" "$expect" "$equality" )
            local choose_line=$( $tasks_sh db show_selected_table koan )

            echo "$equality"
        else
            notify-send1 'skip' 'pushing test forward'
        fi
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






