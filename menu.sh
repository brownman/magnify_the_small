#!/bin/bash

pushd `dirname $0` > /dev/null

. $TIMERTXT_CFG_FILE


dir=$TIMER2_DIR

#echo 'Links:'
#echo 'http://bash.cyberciti.biz/guide/Main_Page'
#echo  'http://www.blackhatlibrary.net/'
#echo  'http://linuxaria.com/pills/how-to-scan-linux-for-vulnerabilities-with-lynis?lang=en'
#echo 'Projects:'
#echo '/TORRENTS/CODE_UNUSED/SOURCE/alarm-clock-applet-0.3.3'
#echo  "$date"

reset
while [ true ];do





    points=$( cat $done_txt | head -1 )
    #white "POINTS:   $points"
    str2="===============   POINTS:     $points  =============="


    red "updated white board "
    red "execute suspension mechanism " 


    white "1 - write schedules and update Kuka"
    white "2 - imagine first"
    white "3 - invest"
    white "4 - profit"
    white "5 - study"
    white "6 - quit"

    green "Enter your level of progress:"
    read level



    #read answer

    if [ "$level" = 5 ]
    then
        white 'start learning'
    elif [ "$level" = 6 ]
    then
        exiting
    elif [ "$level" = 3 ]
    then
        cat $todo_txt 
        read answer
    elif [ "$level" = 4 ]
    then

        ( echo "magnify the small" | flite &)



        white 'update points'
        ( $TIMER2_DIR/edit.sh &)


        #yellow "if false  - PLEASE suspend now !"
    elif [ "$level" = 1 ]
    then
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




        read

    elif [ "$level" = 2 ]
    then
        echo 'imagine first'

        lang=$( gxmessage "which language?" -entry -timeout 10 )
        #lang options: ru , it , hi , tl , ar  
        $dir/timer.sh write_essay $lang

        $dir/timer.sh send_essay $lang

    else
        #yellow "we are here:  "

        white "\t\t $( date | awk -F ' ' '{print $4}' )   "
        white "$str2"

        str=`cat  "$todo_txt" | head -2`
        cyan "$str" 

        #white "agree ?"

    sleep1 5
        #dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend
    fi


    #echo 'take a breath !'
    #sleep1 5
    reset
done












exiting

str=`cat  "$todo_txt" | head -2`
echo  "Ofer - I believe you !" # | flite
str1=""

PS3=$str2
#local answer=
options=( "Quit" "Reminder" "Rule" "Idea" "Imagine" "Unlock" "Points" )
select opt in "${options[@]}"
do



    case $opt in
        "Imagine")
            lang=$( gxmessage "which language?" -entry -timeout 10 )
            #lang options: ru , it , hi , tl , ar  
            $dir/timer.sh write_essay $lang

            $dir/timer.sh send_essay $lang
            ;;
        "Quit")
            exit
            ;;
        "Points")
            $dir/edit.sh
            ;;
        "Idea")
            white "update ideas.txt:"
            read str1
            touch $ideas_txt
            if [ "$str1" != '' ]
            then
                echo "$str1" >> $ideas_txt
            fi
            ;;
        "Rule")
            echo invalid option
            white "update rules.txt:"
            read str1
            touch $rules_txt
            if [ "$str1" != '' ]
            then

                echo "$str1" >> $rules_txt
            fi
            ;; 
        "Reminder")
            str=`cat "$rules_txt"`
            cyan "REMINDER FILE: \n $str"

            str=`cat  "$ideas_txt" `
            yellow "IDEAS FILE: $str" 

            str=`cat  "$todo_txt" | head -2`
            green "TODO FILE: $str" 
            ;;
        "Unlock")
            yellow "I am aware of the time - let me go in !"
            break
            ;;
        *)
            echo 'LET ME IN !' 
            ;;
    esac
done

green 'going on to submenu !' 


options=( "Quit" "TIMER!"  "Record" "Configuration" "Edit" "fetch" "Wallpaper" "mail"  "blogging" "testing" "github" "Job" "Delete" )
select opt in "${options[@]}"
do
    case $opt in
        "TIMER!")
            if [ -t 0 ]; then stty -echo -icanon time 0 min 0; fi

            count=0
            keypress=''
            while [ "x$keypress" = "x" ]; do


                let count+=1
                echo -ne $count'\r'
                read keypress

                $dir/timer.sh series 
                sleep 10s
            done

            if [ -t 0 ]; then stty sane; fi

            echo "You pressed '$keypress' after $count loop iterations"
            echo "Thanks for using this script."
            exit 0

            #$dir/timer.sh all


            ;;
        "Job")
            echo 'open: linkin, check mails, etc'
            ;;


        "Delete")
            echo 'delete txt files'
            $dir/timer.sh delete
            ;;

        "Record")
            title=$( gxmessage "please title the screencast:" -entry )
            asciiio -t "$title"

            ;;
        "Configuration")
            vi $dir/cfg/timer.cfg
            ;;

        "Wallpaper")
            $dir/wallpaper.sh
            ;;


        "github")
            git add .
            line=$( gxmessage -buttons "I did add a presentation!" "write description for the commit" -entry -timeout 20 -title "Github update: ")
            if [ "$line" != '' ]
            then
                git commit -am "$line"
                git push origin develop
            fi

            ;;


        "fetch")
            $dir/fetch.sh
            ;;
        "mail")
            $dir/mail.sh 
            ;;

        "blogging")
            lang=$( gxmessage "which language?" -entry -timeout 10 )
            #lang options: ru , it , hi , tl , ar  
            $dir/timer.sh write_essay $lang

            $dir/timer.sh send_essay $lang
            ;;

        "testing")
            $dir/meditate.sh
            ;;
        "Quit")
            break
            ;;
        "Edit")
            vi .
            ;;

        *) echo invalid option;;
    esac
done
popd > /dev/null
exit
