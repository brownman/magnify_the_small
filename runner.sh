#!/bin/bash

pushd `dirname $0` > /dev/null

export TIMERTXT_CFG_FILE=~/.bash_it/ofer1/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
dir=$TIMER2_DIR


#str3=`echo -n 'NOW: '; cat  "$todo_txt" | head -2 | awk -F '|' '{print $2}' `





while [ true ];do
    reset
    log1
    yellow "choose mode: Txt/Play/Edit/Continue/Quit"

    read answer
  
    if [ "$answer" = q ]
    then
        exiting
    elif [ "$answer" = c ]
    then
        $PWD/menu.sh

    elif [ "$answer" = t ]
    then
        echo2 "edit .txt files"
        . $TIMER2_DIR/edit.sh

    elif [ "$answer" = e ]
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

         white "add a sentence to glossary.txt:"  
     
        read answer
  
        if [ "$answer" != '' ]
        then
            echo "$answer" >> $glossary_txt
        fi
            
    
       cat $glossary_txt 
       white "choose a language: (it/ru/ar/hi/tl) "  
        read answer
  
        if [ "$answer" != '' ]
        then

        $timer_sh write_essay $answer
        fi
       

            
    fi




done

popd > /dev/null
exit
