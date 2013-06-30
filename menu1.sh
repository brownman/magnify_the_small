#!/bin/bash

pushd `dirname $0` > /dev/null
. $TIMERTXT_CFG_FILE
dir=$TIMER2_DIR
str=`cat  "$todo_txt" | head -2 | awk -F '|' '{print $2}' `
str1=""
points=$( cat $done_txt | head -1 )

#cat $file1 | awk -F : '{print $2}'
#white "POINTS:   $points"
str2="===============my   POINTS:     $points  =============="
PS3=$str2
options=( "Update txt" "My state" "schedule report" "Quit" )


reset
blue  "update tasks" # | flite

select opt in "${options[@]}"
do

    case $opt in


   "schedule report")
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
        "Quit")
            exiting
            ;;
        "Update txt")

            white "update ideas.txt:"
            $dir/edit.sh
            ;;
        "My state")
   str=`cat  "$todo_txt" | head -2`
            red "TODO FILE: $str" 

            str=`cat "$done_txt"`
            cyan "REMINDER FILE: \n $str"

         

            str=`cat  "$questions_txt" `
            white "TODO FILE: $str" 

            str=`cat  "$ideas_txt" `
            yellow "IDEAS FILE: $str" 
            ;;
        "Unlock")
            yellow "I am aware of the time - let me go in !"
            break
            ;;
        *)
            reset
            echo 'LET ME IN !' 
            ;;
    esac
done

green 'going on to submenu !' 
blue 'life is happend when you dont put notice'
cat $life_txt

popd > /dev/null
exit
