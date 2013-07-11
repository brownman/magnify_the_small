#!/bin/bash

pushd `dirname $0` > /dev/null
#. $TIMERTXT_CFG_FILE
#dir=$TASKS_DIR
str1=""

PS3="Updating:" 
options=(  "Quit" "Delete" "Schedule" "Record & Publish" )


reset
blue  "update tasks" # | flite

select opt in "${options[@]}"
do

    case $opt in
        "Record & Publish")
            $timer_sh present1
            ;;

        "Schedule")
            echo 'write schedules and update kuka'
            echo 'open website ?'
            read answer
            if [ "$answer" = 'y' ]
            then
                ( xdg-open https://www.google.com/calendar/render?tab=mc &)
                ( xdg-open https://mail.google.com/tasks/ig?pli=1 &)
            fi
            echo 'fetch ?'
            read answer
            if [ "$answer" = 'y' ]
            then
                echo 'fetch'
                $TASKS_DIR/fetch.sh
            fi
            echo 'edit .txt ?'
            read answer
            if [ "$answer" = 'y' ]
            then
                echo 'edit'
                $TASKS_DIR/edit.sh
            fi
            echo 'update wallpaper picture ?'
            read answer
            if [ "$answer" = 'y' ]
            then
                echo 'update wallpaper'
                $TASKS_DIR/edit.sh
            fi

            echo 'update mindmap ?'
            read answer
            if [ "$answer" = 'y' ]
            then
                echo 'mindmap'
                xdg-open "http://drichard.org/mindmaps/#"

            fi

            echo 'email report ?'
            read answer
            if [ "$answer" = 'y' ]
            then
                echo 'mail'
                $TASKS_DIR/mail.sh
            fi
            $TASKS_DIR/mail2.sh
            ;;
        "Delete")
            echo 'delete txt files'
            $timer_sh delete
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
