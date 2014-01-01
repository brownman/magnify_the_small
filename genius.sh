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
show_env(){
red show_env
green "MUTE_CHILD: $MUTE_CHILD"
sleep1 5
}
show_env
if [ "$input" = '' ];then
  
trace 'no arguments to genius'
else
    file11=$dir1/$input.sh

    result=$( $file11 "${args[@]}"  )
  
fi

#str=$(service cron status)
#cmd="notify-send1 cron '$str'"
#every "$cmd" 10
#
echo "$result"
popd > /dev/null


