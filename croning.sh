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

    flite "current cron job is $str1"
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

notify-send1 step1
$( $file single "$str1" )
notify-send1 step2
$( $file single update_points "cron-job-$str1" cron )

#$( $file single wallpaper )
}

run
flite "bye bye"

