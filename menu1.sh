#!/bin/bash

pushd `dirname $0` > /dev/null
. $TIMERTXT_CFG_FILE
dir=$TIMER2_DIR
str1=""

PS3="Updating:" 
options=(  "Quit" "Delete" "Schedule" "Github" )


reset
blue  "update tasks" # | flite

select opt in "${options[@]}"
do

    case $opt in


   "Schedule")
        echo 'write schedules and update kuka'

        ( xdg-open https://www.google.com/calendar/render?tab=mc &)
        ( xdg-open https://mail.google.com/tasks/ig?pli=1 &)
        sleep1 2
        echo 'fetch ?'
        read answer
        if [ "$answer" = 'y' ]
        then

            echo 'fetch'
            $TIMER2_DIR/fetch.sh
        fi
        sleep1 2
        echo 'email report ?'
        read answer
        if [ "$answer" = 'y' ]
        then

            echo 'mail'
            $TIMER2_DIR/mail.sh
        fi
        sleep1 5

        $TIMER2_DIR/mail2.sh

        ;;

     "Delete")
            echo 'delete txt files'
            $dir/timer.sh delete
            ;;
        "Quit")
            exiting
            ;;
       



        "Unlock")
            yellow "I am aware of the time - let me go in !"
            break
            ;;
        *)
            reset
            ;;
    esac
done

green 'going on to submenu !' 
blue 'life is happend when you dont put notice'
cat $life_txt

popd > /dev/null
exit
