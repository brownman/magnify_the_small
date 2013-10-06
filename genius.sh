#!/bin/bash
pushd `dirname $0` > /dev/null



#echo 'zz'
export ROOT_DIR=$PWD
export file_loader=$ROOT_DIR/script/loader.sh
. $file_loader

export COMMANDER=false
input="$1"

dir1=$SCRIPT_DIR/time
dir2=$SCRIPT_DIR/more
result='equal'

menu(){
    local title='execute:'
    local text='list dir:'




    local file=$( list_dir $dir1 "$title" "$text" false )
    local choose=${dir1}/${file}
    local res=0
     
    if [ "$choose" != '' ];then
        
        messageYN1 "$file"
        res=$?
        
        if [[ $res -eq 1 ]];then
         /usr/bin/xterm -e "$choose"
        sleep1 3 

        else
            notify-send 'escape'

        $tasks_sh motivation glossary
        fi
    fi
    echo 'end'
}



loop(){
while :;do
 once 
. $file_loader
done
}
once(){
  menu
    sleep1 5
}

run(){
      loop
}

if [ "$input" = '' ];then
    notify-send 'run:' 'menu'
    run
else

    result=$( $dir2/${input}.sh )
fi

    #echo "res: $result"

echo "$result"
popd > /dev/null



