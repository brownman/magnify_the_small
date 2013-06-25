#!/bin/bash
PS3='Please enter your choice: '
dir=ofer1
options=( "Quit" "Record" "Configuration" "Edit" "All" "1 task" "fetch" "Wallpaper" "mail"  "blogging" "testing" "github" )
select opt in "${options[@]}"
do
    case $opt in
        "All")
            $dir/timer.sh all
            ;;

        "Record")
            title=$( gxmessage "please title the screencast:" -entry )
            asciiio -t $title

            ;;
        "Configuration")
            vi $dir/cfg/timer.cfg
            ;;

        "Wallpaper")
            $dir/edit.sh
            ;;


        "github")
            git add .
            line=$( gxmessage "write description for the commit" -entry -timeout 20 -title "Github update: ")
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
        "1 task")

            $dir/timer.sh one_task

            ;;
        "blogging")
            lang=$( gxmessage "which language?" -entry -timeout 10 )
            #lang options: ru , it , hi , tl , ar  
            $dir/timer.sh write_essay $lang
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
