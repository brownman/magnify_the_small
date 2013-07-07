#!/bin/bash

pushd `dirname $0` > /dev/null

export TIMERTXT_CFG_FILE=~/.bash_it/ofer1/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
export VERBOSE=true


cat -n $motivations_txt
read 
learn1(){
    echo 'learn1'
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
}

play1(){
    echo 'play1'
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
        $TIMER2_DIR/timer.sh series "$series1" 
        ##############################################################
        sleep1 10
    done

    if [ -t 0 ]; then stty sane; fi

    echo "You pressed '$keypress' after $count loop iterations"
    echo "Thanks for using this script."
    exit 0
}
play2(){
    sleep1 60
    echo 'play1'
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
        $TIMER2_DIR/timer.sh series "one_task" 
        ##############################################################
        sleep1 10
    done

    if [ -t 0 ]; then stty sane; fi

    echo "You pressed '$keypress' after $count loop iterations"
    echo "Thanks for using this script."
    exit 0
}

remind1(){

    #reset
    #echo "$str2"
    white "does the timer run with suspension ?"
    green "do you have schedules ?"
    white "did you write on the whiteboard ?"
    green "runner.sh - play motivations"
    red "klara - mother reminder"
    log1

}



#yellow "choose:\nEdit .txt\nPlay timer tasks\nUpdate .sh\nContinue to next menu\nQuit"




present1(){
    green 'post to blog ?'
    read answer
    if [  "$answer" = y ]
    then
        echo '~/.bash_it/blog/brownman.github.com'
        echo 'Jakyll serve'
        echo 'rake post title="day X: goal X"'
    fi


    green 'record screencast?'
    read answer
    if [  "$answer" = y ]
    then
        title=$( gxmessage "please title the screencast:" -entry )
        asciiio -t "$title"

    fi
    green 'add presentation to the README..?'
    read answer
    if [  "$answer" = y ]
    then
        echo "$?"
        gedit README.md
    fi
    green 'publish to github ?'
    read answer
    if [  "$answer" = y ]
    then
        git add .
        line=$( gxmessage -buttons "I did add a presentation!" "write description for the commit" -entry -timeout 20 -title "Github update: ")
        if [ "$line" != '' ]
        then
            git commit -am "$line"
            git push origin develop
        fi
    fi
}




PS3=$( yellow "\nRunner Menu:" )

#cyan  "\t\t\t\t Parent Menu" 
options=("Quit"   "Record & Publish"  "Edit .txt" "Play timer" "Update .sh" "Next menu" "motivation" "best idea" "game" "security" )

remind1
#yellow "choose:\nEdit .txt\nPlay timer tasks\nUpdate .sh\nContinue to next menu\nQuit"
select opt in "${options[@]}"
do
    #echo "my status is:"



    case $opt in
     "security")
            echo 'security hole'

echo 'check system security:'



( xterm -e 'sudo lynis --check-all -Q' &)

 vi /usr/sbin/lynis
            ;;

        "game")
            echo 'memory game'
            $timer_sh game 

            ;;
        "best idea")
            echo "add idea:"
            read answer

            if [ "$answer" != '' ];then
                echo "$answer" >> $ideas_txt 
            fi
            cat -n $ideas_txt
            ;;

        "motivation")
            echo "everything is funny actualy"
            read answer

            if [ "$answer" != '' ];then
                echo "$answer" >> $motivations_txt 
            fi
            cat -n $motivations_txt
            ;;
        "Record & Publish")
            present1

            ;;
        "Edit .txt")
            echo2 "edit .txt files"
            . $TIMER2_DIR/edit.sh
            ;; 
        "Play timer")
            play2 &
            play1 
            ;;
        "Update .sh")
            echo2 "edit .cfg/.sh files" 
            vi $TIMER2_DIR/cfg/timer.cfg
            ;;
        "Next menu")

            $PWD/menu.sh
            ;;
        "Quit")
            exiting
            ;;

        *)

            reset
            learn1
            #exiting
            echo 'LET ME IN !' 

            ;;

    esac
done




popd > /dev/null
exiting



