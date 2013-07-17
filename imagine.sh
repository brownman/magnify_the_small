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
guidance(){

    red "post commitment to blog ?"
    read answer
    if [ "$answer" = y ];then
        red 'share your commitment'
        echo 'choose guide: philo'
        file_guide=$STORY_DIR/commitment.txt
        $SCREENS_DIR/motivation.sh "$file_guide"
    fi
    cyan "encourage yourserlf ?"
    read answer
    if [ "$answer" = y ];then
        yellow 'you are in a good place because:'
        echo 'choose guide: philo'
        file_guide=$STORY_DIR/encouragments.txt
        $SCREENS_DIR/motivation.sh "$file_guide"

    fi

    cyan "creative ?"
    read answer
    if [ "$answer" = y ];then
        cyan 'have profit !'
        yellow 'imagine an ideal day !'
        file_guide=$STORY_DIR/children_song.txt
        $SCREENS_DIR/motivation.sh $file_guide 
    fi

    cyan "glossary of the day ?"
    read answer
    if [ "$answer" = y ];then
        cyan 'have profit !'
        yellow 'imagine an ideal day !'
        cat $glossary_txt
        file_guide=$STORY_DIR/glossary.txt
        #http://en.wiktionary.org/wiki/Wiktionary:Frequency_lists
        cat $file_guide
        read 
        $SCREENS_DIR/motivation.sh $file_guide

    fi
}

one_step_aday(){
    cyan "update jobs links ?"
    read answer
    if [ "$answer" = y ];then
        gedit $jobs_txt
    fi
    cyan "learn instide of me ?"
    read answer
    if [ "$answer" = y ];then
        #xdg-open dd"http://www.commandlinefu.com/commands/tagged/185/lynx/sort-by-votes"
        #lynx -dump randomfunfacts.com | grep -A 3 U | sed 1D
        cyan "do progress in .."
        edit $STORY_DIR/plan.txt
        #$PUBLIC_DIR/koans/meditate.sh
    fi

    cyan "scrap koan ?"
    read answer
    if [ "$answer" = y ];then
        #xdg-open "http://www.commandlinefu.com/commands/tagged/185/lynx/sort-by-votes"
        lynx -dump randomfunfacts.com | grep -A 3 U | sed 1D

    fi
    cyan "db koan ?"
    read answer
    if [ "$answer" = y ];then
        #xdg-open "http://www.commandlinefu.com/commands/tagged/185/lynx/sort-by-votes"
        lynx -dump randomfunfacts.com | grep -A 3 U | sed 1D

    fi


}
breakthrough(){
    cyan "break free ?"
    cyan "praise the lord ?"
    read answer
    if [ "$answer" = y ];then
        gedit $quotes_txt &
        gedit $motivations_txt &
        yellow 'challenge: scrap a phrase website'
    fi
    cyan "update state ?"
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
    guidance
}

reminder(){

    yellow "Remind:"
    cyan "update project's goals ?"
    read answer
    if [ "$answer" = y ];then
        gedit $readme_md 
    fi


    cyan "show priorities  ?"
    read answer
    if [ "$answer" = y ];then

        gedit $done_txt &
        gedit $todo_txt &
        gedit $timing_txt &

        xdg-open $url_calendar & 
        xdg-open $url_tasks &
    fi
}

eacher(){
    echo2 "eacher() got: 1: $1     2: $2"
    question="$2"
    command="$1"

    green "$question"
    read answer
    if [ "$answer" = y ];then
        eval "$command"
    fi
}
efficiency_proof(){
    yellow "what is the status of the blog ?"
    green "what is your status of memorize new glossary's words ?"
    red "please give answers every 30 minutes"
}

forign_language(){
    echo2 'forign language()'
    command="$SCREENS_DIR/motivation.sh practice" 
    eacher "$command" "practice frequent word ?"

}
relax(){
    command="$SCREENS_DIR/motivation.sh listen" 
    eacher "$command" "listen to words of peace ?"
}

log3(){

    str9=`cat  "$glossary_txt"  | head -3`
    str8=`cat  "$product_txt"  | head -3`
    str7=`cat  "$motivations_txt" | head -3 `

    str2=$( cyan "$str7"; white "$str8" ;green "$str9" )

    echo "$str2"
    yellow 'clean yesturday files';
    green 'set priorities of todos';
    white 'update calendar, tasks';
    white "update today's plans";
    white "update goals: 1 step aday";
    yellow "2. set a workflow and run it in loop !";
}
log4(){
    str2=$(   

    cat -n $STORY_DIR/workflow_morning.txt
    )

    echo "$str2"
}

new_day(){

    msg1=`log4`
    #msg1="print me!"
    $PUBLIC_DIR/menus.sh "$msg1"
}



expend(){
    yellow 'edit .txt ?'
    read answer
    if [ "$answer" = y ];then
        cyan "please update the timer workflow"
        gedit $priorities_txt
        gedit $study_txt
        gedit $efficiency_txt
    fi
    green "current workflow:"
    echo "$workflow"
    yellow 'test the workflow ?'
    read answer
    if [ "$answer" = y ];then
        xterm -e "$SCREENS_DIR/periodic.sh \"$workflow\""
    fi
    yellow 'continue to menu ?'
    read answer
    if [ "$answer" = y ];then

        $PUBLIC_DIR/menus.sh
    fi
}


update_auto(){
    eacher forign_language "learn something new ?"
    eacher efficiency_proof "efficiency proof ?"
    eacher breakthrough "need to cut what you currently doing ?" 
    eacher reminder "remind daily goals ?"
    eacher one_step_aday "add 1 question for each field aday ?" 
}

ideas_bank_for_later(){
    green 'edit ideas ?' 
    read answer
    if [ "$answer" = 'y'  ];then
        gedit $ideas_txt &
        gedit $STORY_DIR/words_of_peace.txt &
    fi
    green 'upgrade productivity ?' 
    read answer
    if [ "$answer" = 'y'  ];then
        gedit $readme_md &

    fi

    relax

}
breakout_idea_prison(){

    eacher ideas_bank_for_later 'need to break free ?'
    #asave idea for later and connect earth ?'
}

statistics(){
    red 'pinging a server to report productivity level..'
sleep1 4
echo -n 'productivity level:  '
if [ "$efficiency" = 'low' ];then
    red "low"
     
    yellow "must update workflow to a better one !"
    random_quote1 $STORY_DIR/ground.txt
elif [ "$efficiency" = 'medium' ];then
    yellow 'medium'
elif [ "$efficiency" = 'high' ];then
    green 'high'
else
    'wtf ?'
fi

sleep1 1

}


order_please(){

statistics
breakout_idea_prison



    #cyan "states:"
    #echo "morning|state|ideas|auto" 
    #echo 'enter state:'
    #read mood

    if [ "$mood" != '' ];then


        #maturity=$maturity
        cyan "you are here:"
        echo "morning|state|ideas|auto" | grep $mood
        sleep1 2
        if [ "$mood" = 'morning' ];then
            new_day 
        elif [ "$mood" = 'state' ];then
            reminder 
        elif [ "$mood" = 'ideas' ];then
            ideas_bank_for_later
        elif [ "$mood" = 'auto' ];then
            yellow 'do 1 step aday in X field' 
            sleep1 2
            update_auto
        else
            echo 'are you dead aleady ?'
        fi


    fi

}


if [ "$1" = "periodic" ];then
    $SCREENS_DIR/periodic.sh $workflow
elif [ "$1" = 'menus' ];then
    $PUBLIC_DIR/menus.sh
else
    order_please 
fi





