#!/bin/bash -e
#-x

#set -o errexit

# about file:
# test the first test listen on blank.yaml:testing
#http://www.thegeekstuff.com/2010/10/expect-examples/#more-6218
    #args=$($tasks_sh fetch "$args0")
    #http://tldp.org/LDP/abs/html/comparison-ops.html
    #http://stackoverflow.com/questions/3265803/bash-string-equality
cmd1='$tasks_sh motivation glossary'
#eval "$cmd1" &> /dev/null &
run_silently "$cmd1"


export DEBUG=true
export VERBOSE=false
result='equal'
file_test=/tmp/testing
file_locker='/tmp/test'
delay=10

plugin(){
    $PLUGINS_DIR/$1.sh "$2" "$3"

}
cfg(){
    notify-send 'cfg test'
    "$1" "$2" "$3"
#echo 'cfg'
}
tasks_sh(){

    trace "tasks_sh run: $*"
    #1:$1 2:$2 3:$3"
    $tasks_sh "$@" 
    #"$1" "$2" "$3"
}
test_yaml(){
    trace "$tasks_sh"

local filename=$(get_filename1 tmp testing )

    local line=`cat $filename | head -1`
    #breakpoint
    trace   "$filename" 
    trace   "$line" 
    #tracex  'testing.0:' "$line" 
    if [ "$line" != '' ];then
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
        #echo "$res"
       ################### eval 
        result=$( eval $route '"$method" "$input1" "$input2"')
        ########################

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

}

run(){

 result=$(test_yaml)

#echo "$result"
#flite 'sleep 10 seconds'
#sleep1 4
}
#run
unlocker
echo "$result"






