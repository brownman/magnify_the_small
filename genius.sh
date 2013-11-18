#!/bin/bash 
#-x 
#-v
#http://subsignal.org/doc/AliensBashTutorial.html#4_e
#http://c.learncodethehardway.org/
pushd `dirname $0` > /dev/null
#chmod +w time
#ls -d -l time
notify-send "genius:" "$@"
export ROOT_DIR=$PWD
export file_loader=$ROOT_DIR/script/loader.sh
. $file_loader

input="$1"
shift
args=( "$@" )
#arg1="$2"
#arg2="$3"
#arg3="$4"


dir1=$SCRIPT_DIR/time
#dir2=$SCRIPT_DIR/more

file_locker=/tmp/genius
delay=20
result='equal'
#run2(){
#    local file="$1"
#
#    is_valid $file
#    res=$?
#    trace 'res' $res
##notify-send "$file"
#    if [ $res -eq 1 ];then
#
#        trace 'execution'
#
#        #sleep1 5
#        result=$( exec $file )
#        #$file
#    else
#        trace 'skip execution'
#    fi
#
#
#
#}

if [ "$input" = '' ];then
    notify-send 'run:' 'menu'
#    unlocker
else
    file11=$dir1/${input}.sh
    result=$($file11 "${args[@]}")
    #1" "$arg2" "$arg3"

fi

echo "$result"
popd > /dev/null



