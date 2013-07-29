#!/bin/bash
# about file:
# plugin:        suspend
# description:   suspend the computer + limit powering-on to X seconds
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
suspend01(){
    local elapsed=0
    local before=`date +%s`
    local timeout=30
    echo -n "the timeout is:"
    cyan "$timeout"
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
