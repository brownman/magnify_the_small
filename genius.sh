#!/bin/bash 
#http://subsignal.org/doc/AliensBashTutorial.html#4_e
#http://c.learncodethehardway.org/
pushd `dirname $0` > /dev/null
renice 10 -p $$
#flite 'genius'
#chmod +w time
#ls -d -l time
str="$@"
#notify-send "genius:" "$str"
export ROOT_DIR=$PWD
export file_loader=$ROOT_DIR/script/loader.sh
. $file_loader

input="$1"
shift
args=( "$@" )

trace "pid: $$"
dir1=$SCRIPT_DIR/time
result='equal'

#clean_file "$file_logger"
if [ "$input" = '' ];then
    #notify-send 'run:' 'menu'

#cmd="cat $DATA_DIR/txt/history.txt"
#detach "$cmd"
#    unlocker
trace 'no arguments to genius'
else
    file11=$dir1/$input.sh
#2>&1 >> $file_error
#(ulimit -v 1000000; scriptname)
    result=$( $file11 "${args[@]}"  )
    #result=$($file11 "${args[@]}" 2>&1 >> $file_error )
#somecommand 2>&1 >> logfile | tee -a logfile
#do_something 2>&1
    #1" "$arg2" "$arg3"
fi

#str=$(service cron status)
#cmd="notify-send1 cron '$str'"
#every "$cmd" 10
echo "$result"
popd > /dev/null


