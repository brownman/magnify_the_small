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

    cyan "update project's goals ?"
    read answer
    if [ "$answer" = y ];then
        gedit $readme_md 
    fi

 
    cyan "Remind:"
    cyan "priorities  ?"
    read answer
    if [ "$answer" = y ];then

        #edit $prespective_txt
        gedit $todo_txt &
        gedit $prespective_txt &
        gedit $timing_txt &
        gedit $readme_md &
        xdg-open $url_calendar & 
        xdg-open $url_tasks &
    fi
}

eacher(){
    echo2 "eacher() got: 1: $1     2: $2"
    question="$2"
    command="$1"

    cyan "$question"
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
    command="$SCREENS_DIR/motivation.sh listen" 
    eacher "$command" "listen to words of peace ?"
}

effectivity_spy(){
    cyan "update rules for increase productivity:"
    gedit $rules_txt


    green "current workflow:"
    echo "$workflow"
    echo 'execute the workflow ?'
    read answer
    if [ "$answer" = y ];then
        xterm -e "$SCREENS_DIR/periodic.sh \"$workflow\""
    fi
    $PUBLIC_DIR/menus.sh
}
update_project(){
    reminder
}

update_fun(){
    eacher forign_language "learn something new ?"
    eacher efficiency_proof "efficiency proof ?"
    eacher breakthrough "need to cut what you currently doing ?" 
    eacher reminder "remind daily goals ?"
    eacher one_step_aday "add 1 question for each field aday ?" 
}

ideas_bank_for_later(){

    yellow "update_uml_of_this_project"
    echo 'http://plantuml.sourceforge.net/sequence.html'
    echo 'http://www.plantuml.com/plantuml/'
    echo 'project must have be examed from top level view'

    echo    http://zshwiki.org/home/tutorials

}
order_please(){
    mood=baby

    cyan "you are here:"
    echo "baby|child|grownup|adult" | grep $mood
    sleep1 2
    if [ $mood = 'baby' ];then
        effectivity_spy
    elif [ $mood = 'child' ];then
        update_project
    elif [ $mood = 'grownup' ];then
        ideas_bank_for_later
    elif [ $mood = 'adult' ];then
        update_fun
    else
        echo 'are you dead aleady ?'
    fi

}


if [ "$1" = "periodic" ];then
    $SCREENS_DIR/periodic.sh $workflow
elif [ "$1" = 'menus' ];then
    $PUBLIC_DIR/menus.sh
else
    order_please 
fi





