#!/bin/bash

str1="$1"


info(){
    flite "$str1"
    #cat /home/dao01/tmp/cron-env
    /usr/bin/env -i $(cat /home/dao01/tmp/cron-env)
}
update_env(){
    source /etc/profile
    source /home/dao01/.bashrc
}
run(){
    if [ "$str1" = '' ];then
        flite 'no arguments'
    else
        info
        #flite 'inside function'

        test1
    fi

}
action(){

    /home/dao01/magnify_the_small/genius.sh single "$str1" 

}
gui(){
   #/usr/bin/notify-send "$str1"
    xcowsay "$str1"
    #gxmessage "$str1" -title 'cron' -timeout 5
    #

}
test1(){

    flite "start $str1"
    gui
   action 
    flite "finish $str1"
}

run
flite "bye bye"

