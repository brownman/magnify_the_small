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
cow_report koan
$tasks_sh motivation koan &
    assert_equal_str "koan file"
    #breakpoint
    trace   "$filename" 
    trace   "$line" 
    #tracex  'testing.0:' "$line" 
    #update_table_gui ""
    if [ "$line" != '' ];then


        local desc=$( echo "$line" | awk -F '|' '{print $1}' )


        flite "$desc"
#local cmd="$tasks_sh reminder '$desc'"
#optional "$cmd" &
        #$tasks_sh motivation &
        messageYN1 "$desc" 'recent koan' 
        local res=$?
        if [ $res -eq 1 ];then




            line=$(         update_line "$line" )
            local desc=$( echo "$line" | awk -F '|' '{print $1}' )
            local route=$( echo "$line" | awk -F '|' '{print $2}' )
            local method=$( echo "$line" | awk -F '|' '{print $3}' )
            local inputs=$( echo "$line" | awk -F '|' '{print $4}' )
            local expect=$( echo "$line" | awk -F '|' '{print $5}' )


            #trace "route: $route"
            #local res=$(echo "$inputs")
            #res=$(ls -l  $res)
            #assert_equal_str "$res"
            #echo "$res"
            #inputs="$res"




            local inputs1=$( echo "$inputs" | sed 's/,/ /g' ) 

            #assert_equal_str "$inputs1"
            #awk -F ',' '{print $1}' )
            #inputs2=$( echo "$inputs" | awk -F ',' '{print $2}' )
            #echo "$res"
            ################### eval 
            local cmd=$( echo "$route $method $inputs1" )
            #update_commander
            local result=$(commander "$cmd")
            result="$result"

            #assert_not_equal_str "$result" "" 'must not be empty'






            local equality=$([[ "$result" = "$expect" ]] && echo 'equal' || echo "$result")
            #local equality=$([[ "$result" = "$expect" ]] && echo 'equal' || echo "-$result-!=-$expect-")
            #assert_equal_str "$equality"


            #assert_equal_str "$ans"


            #update_commander


            #assert_equal_str "$ans"

            if [ "$equality" = 'equal' ];then
                notify-send3 'test ok!'




                #update_line  "$choose_line"


            else
                #trace "-$result-!=-$expect-"
                #notify-send1 'test failed'
                notify-send1 'google is a friend ?'
                #local url=http://wiki.bash-hackers.org/rcwatson
                #cmd="echo $(gxmessage $GXMESSAGET 'google is a friend' -entrytext $url);#xargs google-chrome"
                #(every "$cmd" 15  &)
                cmd='notify-send3 " must document the new tests"'
                (every "$cmd" 5  &)
            fi

            local ans=$($tasks_sh db update_table koan true "$desc" "$time1" "$route" "$method" "$inputs1" "$expect" "$equality" )

            local choose_line=$( $tasks_sh db show_selected_table koan )


            #
            #        local equality=$([[ "$result" = "$expect" ]] && echo 'equal' || echo "result:-$result-")
            #
            #        echo -n '' > $file_test
            #        echo "inputs:   -$inputs-" >> $file_test
            #        echo "expect: -$expect-" >> $file_test
            #
            #        local str=$(cat $file_test)
            #
            #        #(trace "$str" "action: $method " "$equality" true &)
            #        trace "action: $method $str $equality"
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






