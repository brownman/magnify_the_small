#!/bin/bash

str1="$1"


info(){

    /usr/bin/env -i $(cat /home/dao01/tmp/cron-env)
}
update_env(){
    #source /etc/profile
    source /home/dao01/.bashrc
}
run(){

    #flite "restart $str1"
    if [ "$str1" = '' ];then
        flite 'no arguments'
    else
        info
       #update_env 
        action 
    fi

}
action(){
local file=/home/dao01/magnify_the_small/genius.sh

$( $file one_cron "$str1" )
}

run
#flite "finish $str1"
