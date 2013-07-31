#!/bin/bash

# about file:
# - recored your steps
# - cherish suspension 
#
export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
reset 
POINTS_SUSPEND=0
POINTS_OTHER_HEART=0
POINTS_REPORT=0
POINTS_IMAGINE=0

update_status(){
    echo "what are you doing right now ?"
    read answer

    if [ "$answer" != '' ];then
        spell1 "$answer"
        cyan 'press u to undo'
        read answer2 
        if [ "$answer2" = 'u' ];then
            log2
        else
            time1=$( date | awk -F ' ' '{print $4}' )

            echo "$time1 | $answer" >> $TODAY_DIR/txt/log.txt
            if [ $PROFIT = true ];then
                $PLUGINS_DIR/translation.sh sentence "$answer" 
            fi
        fi
    fi

}
eacher1(){

    echo2  "eacher() got: 1: $1     2: $2"
    local question="$2"
    local command="$1"
    echo -n  "TASK: "
    green "$question"
    eval "$command" 
    sleep1 5
}


take_guidance(){
    ls -1 $STORY_DIR/guidance/*.txt
}

publish_report(){
    $TASKS_DIR/blogger.sh
}

suspend(){
    $tasks_sh suspend
}

scoring(){
    echo 'your scores are: '
    echo -n 'do for others: '
    cyan $POINTS_OTHER_HEART
    echo -n 'taking a real breath and a look around: '
    cyan $POINTS_SUSPEND
    echo -n 'updating statistics:'
    cyan $POINTS_REPORT
    echo -n 'imagine your goals'
    cyan $POINTS_IMAGINE

}



help1(){
    echo 'gain more points by:'
    echo 'suspending'
    echo 'post a report to the blog'
    echo 'do things you afraid of'
}

interactive(){
    $tasks_sh motivation
}

make_a_breakthrough(){
    echo 'for doing a breakthrough one must sacrifice'
    echo 'open his heart'
    echo 'give more to others'
}
remind(){
    #echo 'suspension is an opportunity' >> $DYNAMIC_DIR/motivations.txt
    #echo 'the day has already been started - stand up now' >> $DYNAMIC_DIR/motivations.txt
    #echo 'making 1 points per 5 minutes is easy' >> $DYNAMIC_DIR/motivations.txt

    $PLUGINS_DIR/translation.sh $DYNAMIC_DIR/motivations.txt

}
entertainment(){
    echo 'play an mp3 while u gona do a real breakthrough !'
}
deepest_fears(){
    #echo 'confront your deapest fears: escape this cycle' >>  $DYNAMIC_DIR/breakthrough.txt
    #echo 'make a breakthrough' >> $DYNAMIC_DIR/breakthrough.txt
    $PLUGINS_DIR/translation.sh $DYNAMIC_DIR/breakthrough.txt
}
step_a_day(){
    echo 'show result of latest progress in field X'
}


pass_to_enlightment(){



    #others:


    #me:

    #family
    #eacher1 update_report 'write a report'

    eacher1 publish_report 'publish the report'
    exiting
    eacher1 deepest_fears 'what are your deepest fears ?'
    eacher1 entertainment 'remind of price'
    eacher1 help1 'show goals'
    eacher1 step_a_day 'push forward - make 1 step in 1 field'
    eacher1 scoring 'current status'
    eacher1 remind 'remind me of the true reasons of what I am doing'

    eacher1 update_status 'update your state'
    suspend #30 seconds
}

pass_to_enlightment
