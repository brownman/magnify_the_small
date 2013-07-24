#!/bin/bash
# about file:
# collection of system tasks
# no gui here - remove gxmessage 
# 
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE

suspend(){
    #touch $now_txt
    local elapsed
    #take_photo
    #last_commitment=`cat $now_txt | head -1`
    #echo4 "$last_commitment" 
    #echo4 "$msg_suspend" 

    #choose5 $DYNAMIC_DIR/motivation/glossary.txt
    local before=`date +%s`
    echo -n "the timeout is:"
    cyan "$TIMEOUT1"
    sleep1 5
    dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend

    #choose4 $DYNAMIC_DIR/wish.txt

    #. $TIMERTXT_CFG_FILE
    local after=`date +%s`

    let elapsed=after-before

    #gxmessage -title 'suspend for:'  "$elapsed" $GXMESSAGET

    if [[ $elapsed -lt $TIMEOUT1 ]];then
        echo "let me sleep for at least $TIMEOUT1 seconds"
        suspend
    fi
}

suspend
