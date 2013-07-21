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
#. $TIMERTXT_CFG_FILEadd_line



export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
reset 

echo2 "imagine.sh got:  1: $1 2: $2 3: $3"
pids1 "$0" 





glossary_aday(){
        cyan 'have profit !'
        yellow 'imagine an ideal day !'
        cat $glossary_txt
        file_guide=$MORNING_DIR/glossary.txt
        #http://en.wiktionary.org/wiki/Wiktionary:Frequency_lists
        cat $file_guide
        read 
        $SCREENS_DIR/motivation.sh $file_guide
}






uml_me(){
#echo 'http://bash.cyberciti.biz/guide/Source_command'
#echo http://www.offensive-security.com/metasploit-unleashed/Getting_A_Shell
#xdg-open http://www.plantuml.com/plantuml/ &
#blue 
#xdg-open 'http://plantuml.sourceforge.net/activity2.html#simple' &
#blue 'http://alternativeto.net/?platform=linux'
yellow 'save the world for those who left behind !'
sleep1 2
eacher glossary_aday "glossary of the day ?"
eacher breakout_idea_prison "breakout idea prison ?"
eacher new_day "uml a day ?"
}
new_day(){

    msg1=`log4`
    #msg1="print me!"
    $PUBLIC_DIR/menus.sh "$msg1"
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

if [ "$1" = "test" ];then


    echo 'test'

$tasks_sh  suspend

elif [ "$1" = "periodic" ];then
    $SCREENS_DIR/periodic.sh
    #$workflow
elif [ "$1" = 'menus' ];then
    $PUBLIC_DIR/menus.sh
elif [ "$1" = 'help' ];then
    echo -n 'second arg: '
    cyan 'menus OR periodic'
else
    uml_me
fi





