#!/bin/bash 
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
dir1=$SCRIPT_DIR/time
result='equal'

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



