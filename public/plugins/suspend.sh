#!/bin/bash
# about file:
# plugin:        suspend
# description:   suspend the computer + limit powering-on to X seconds
# unlock: https://bugs.launchpad.net/ubuntu/+source/dbus/+bug/811441
# progress bar: http://bash.cyberciti.biz/guide/A_progress_bar_(gauge_box)
. $TIMERTXT_CFG_FILE
timeout=$TIMEOUT_LET_ME_SLEEP


suspend01(){
    echo2 "suspend01().."
    local elapsed=0
    local before=`date +%s`

    echo -n "let me sleep timeout -  is:"
    cyan "$timeout"
    #echo0 "you have $timeout seconds to accomplish your task - go !" 
    #reminder
    sleep1 5
    res=$( dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend )
    echo2 "res:  $res"
    local after=`date +%s`
    let elapsed=after-before
    echo -n "slept for: "
    cyan "$elapsed"
    if [[ $elapsed -lt $timeout ]];then
        echo "let me sleep for at least $timeout seconds"
        sleep1 5
        suspend01
    else
        green 'you are free now - act wisely'
    fi
}



suspend01

