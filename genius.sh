#!/bin/bash 
#-v
#http://subsignal.org/doc/AliensBashTutorial.html#4_e
#http://c.learncodethehardway.org/
pushd `dirname $0` > /dev/null
#chmod +w time
#ls -d -l time

export ROOT_DIR=$PWD
export file_loader=$ROOT_DIR/script/loader.sh
. $file_loader

input="$1"


dir1=$SCRIPT_DIR/time
dir2=$SCRIPT_DIR/more

file_locker=/tmp/genius
delay=20
result='equal'
shit(){
    local file="$1"

    is_valid $file
    res=$?
    trace 'res' $res
#notify-send "$file"
    if [ $res -eq 1 ];then

        trace 'execution'

        #sleep1 5
        result=$( exec $file )
        #$file
    else
        trace 'skip execution'
    fi



}
if [ "$input" = '' ];then
    notify-send 'run:' 'menu'
#    unlocker
else
    
    file11=$dir1/${input}.sh
    file22=$dir2/${input}.sh
  #shit $file11 

  trace "$file22"
  trace "$file11"

  shit $file11 
  shit $file22 
fi

echo "$result"
popd > /dev/null



