#!/bin/bash

# about file:
# tought-proxy-command
# 1 file to rule them all
# 
#
#
#. $TIMERTXT_CFG_FILE
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE

series_on_suspend='schedule,edit,sleep,suspend,edit,sleep,sleep,remind_me'
echo2 "imagine.sh got:  1: $1 2: $2 3: $3"



#echo "$timer_sh"
declare -i num 
#declare -i max  
########################### choose your destiny ########################
export workflow_suspension="run"
export workflow_periodic="suspend->tasks"
export workflow_morning="blog,readme,record"
export workflow_money="find task -> increase points"
export workflow_motivation="find quote -> translte it"
########################################################################

cyan "prespective|you are here"
echo "suspend|testing|menus|scrap|periodic|task|motivation" | grep menus

#result=` echo "$workflow_morning" | grep -o "$1" `
if [ "$1" = 'suspend' ];then
    $timer_sh series "$series_on_suspend"
elif [ "$1" = 'testing' ];then
    $PUBLIC_DIR/koans/meditate.sh
elif [ "$1" = 'menus' ];then
    $PUBLIC_DIR/menus.sh
elif [ "$1" = 'scrap' ];then
    #$TASKS_DIR/scrap.sh "$2" "$3"
    $PUBLIC_DIR/koans/meditate.sh
elif [ "$1" = 'periodic' ];then
    $SCREENS_DIR/periodic.sh #"$2" "$
elif [ "$1" = 'task'  ];then
    $timer_sh "$2"

elif [ "$1" = 'motivation'  ];then
    echo 'assuming you wants alittle attention:'
    #echo 'series: motivation, prespective, commi'

    $SCREENS_DIR/motivation.sh  
else

    $PUBLIC_DIR/menus.sh

fi

