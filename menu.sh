#!/bin/bash

. $TIMERTXT_CFG_FILE
echo 'Links:'
red 'http://bash.cyberciti.biz/guide/Main_Page'
blue 'http://www.blackhatlibrary.net/'
green 'http://linuxaria.com/pills/how-to-scan-linux-for-vulnerabilities-with-lynis?lang=en'


PS3='Please enter your choice: '
dir=ofer1
options=( "Quit" "Record" "Configuration" "Edit" "All" "task" "fetch" "Wallpaper" "mail"  "blogging" "testing" "github" "Job" )
select opt in "${options[@]}"
do
    case $opt in
        "All")
            $dir/timer.sh all
            ;;
     "Job")
echo 'open: linkin, check mails, etc'
            ;;

        "Record")
            title=$( gxmessage "please title the screencast:" -entry )
            asciiio -t "$title"

            ;;
        "Configuration")
            vi $dir/cfg/timer.cfg
            ;;

        "Wallpaper")
            $dir/edit.sh
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
        "task")

            $dir/timer.sh one_task

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
