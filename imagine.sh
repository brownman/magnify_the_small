#!/bin/bash

# about file:
# first page:
#  - plan your day
#  - childish motivation
#  - connect to earth
#  - do tasks 
#  - learn
#
#
#. $TIMERTXT_CFG_FILE
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
reset 
echo2 "imagine.sh got:  1: $1 2: $2 3: $3"



plan(){
    cyan "praise the lord ?"
    read answer
    if [ "$answer" = y ];then
        gedit $quotes_txt &
        gedit $motivations_txt &
        yellow 'challenge: scrap a phrase website'
    fi
    cyan "break free ?"

    read answer
    if [ "$answer" = y ];then
        cyan 'how do you plan to set yourself free now ?'
        read answer
        if [  "$answer" != '' ];then

            echo "$answer" >>  $done_txt
            echo5 "$answer"
            gedit $done_txt
            yellow "good"
            $timer_sh motivation_random
            
            
        fi

    fi
    red "post commitment to blog ?"
    read answer
    if [ "$answer" = y ];then
        red 'share your commitment'
        echo 'choose guide: philo'
        file_guide=$STORY_DIR/commitment.txt
        $SCREENS_DIR/motivation.sh "$file_guide"
    fi
    cyan "priorities ?"
    read answer
    if [ "$answer" = y ];then

        gedit $todo_txt &
        gedit $prespective_txt &
        gedit $timing_txt &
        gedit $readme_md &
        xdg-open $url_calendar & 
        xdg-open $url_tasks &
    fi
    cyan "prespective ?"
    read answer
    if [ "$answer" = y ];then
        gedit $prespective_txt

        cyan "update jobs links ?"
        read answer
        if [ "$answer" = y ];then
            gedit $jobs_txt
        fi

    fi


    cyan "guidance ?"
    read answer
    if [ "$answer" = y ];then
        cyan 'have profit !'
        yellow 'imagine an ideal day !'
        $SCREENS_DIR/motivation.sh 
    fi

    cyan "update project's goals ?"
    read answer
    if [ "$answer" = y ];then
        gedit $readme_md 
    fi

    green "current workflow:"
    echo "$workflow"
    echo 'execute the workflow ?'
    read answer
    if [ "$answer" = y ];then
        xterm -e "$SCREENS_DIR/periodic.sh \"$workflow\""
    fi


}


if [ "$1" = "periodic" ];then
    $SCREENS_DIR/periodic.sh $workflow
elif [ "$1" = 'menus' ];then
    $PUBLIC_DIR/menus.sh
else
    plan
fi





