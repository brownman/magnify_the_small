#!/bin/bash

pushd `dirname $0` > /dev/null
. $TIMERTXT_CFG_FILE
dir=$TIMER2_DIR
str=`cat  "$todo_txt" | head -2`
str1=""
points=$( cat $done_txt | head -1 )
#white "POINTS:   $points"
str2="===============my   POINTS:     $points  =============="
PS3=$str2
options=( "Quit" "Publish" "Record"  "Study" "Config")


reset
white  "Study" # | flite
select opt in "${options[@]}"
do

    case $opt in
      "Record")
            title=$( gxmessage "please title the screencast:" -entry )
            asciiio -t "$title"

            ;;


        "Publish")
            git add .
            line=$( gxmessage -buttons "I did add a presentation!" "write description for the commit" -entry -timeout 20 -title "Github update: ")
            if [ "$line" != '' ]
            then
                git commit -am "$line"
                git push origin develop
            fi

            ;;

     "Quit")
         
                exiting
            ;;
        "Study")
            echo 'study'
            
            
                $dir/timer.sh series 
            ;;
        *)
            reset
            echo 'LET ME IN !' 
            ;;
    esac
done

popd > /dev/null
exit
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

