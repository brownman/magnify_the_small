#!/bin/bash

pushd `dirname $0` > /dev/null

export TIMERTXT_CFG_FILE=~/.bash_it/ofer1/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
dir=$TIMER2_DIR


#str3=`echo -n 'NOW: '; cat  "$todo_txt" | head -2 | awk -F '|' '{print $2}' `





while [ true ];do
    reset
    echo "does the timer run with suspension ?"
    log1

  
 
        
    yellow "choose:\nEdit .txt\nPlay timer tasks\nUpdate .sh\nContinue to next menu\nQuit"

    read answer
  
    if [ "$answer" = q ]
    then
        exiting
    elif [ "$answer" = c ]
    then
        $PWD/menu.sh

    elif [ "$answer" = e ]
    then
        echo2 "edit .txt files"
        . $TIMER2_DIR/edit.sh

    elif [ "$answer" = u ]
    then
        echo2 "edit .cfg/.sh files" 
        vi $TIMER2_DIR/cfg/timer.cfg

    elif [ "$answer" = p ]
    then




        green 'run series of tasks in circle'
        if [ -t 0 ]; then stty -echo -icanon time 0 min 0; fi

        count=0
        keypress=''
        while [ "x$keypress" = "x" ]; do

            . $TIMERTXT_CFG_FILE

            let count+=1
            echo -ne $count'\r'
            read keypress

            ##############################################################
            $dir/timer.sh series "$SERIES1" 
            ##############################################################
            sleep1 10
        done

        if [ -t 0 ]; then stty sane; fi

        echo "You pressed '$keypress' after $count loop iterations"
        echo "Thanks for using this script."
        exit 0

    else
       # $PWD/menu.sh
green 'learn X words aday: use glossary.txt'
   cat "$dir_essay/essayIT.txt"
    cat "$dir_essay/essayRU.txt"
    cat "$dir_essay/essayHI.txt"
    cat "$dir_essay/essayAR.txt"
    cat "$dir_essay/essayTL.txt"

    
       white "choose a language: IT TL RU HI AR "  
        read lang 

        if [ "$lang" != '' ]
        then

       gedit $glossary_txt & 
        $timer_sh learn_lang $lang $LESSON
        #write_essay $answer
        fi
       


            
    fi




done

popd > /dev/null
exit

