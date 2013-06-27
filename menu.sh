#!/bin/bash

pushd `dirname $0` > /dev/null

. $TIMERTXT_CFG_FILE
echo 'Links:'
red 'http://bash.cyberciti.biz/guide/Main_Page'
blue 'http://www.blackhatlibrary.net/'
green 'http://linuxaria.com/pills/how-to-scan-linux-for-vulnerabilities-with-lynis?lang=en'
echo 'Projects:'
echo '/TORRENTS/CODE_UNUSED/SOURCE/alarm-clock-applet-0.3.3'

PS3='Please enter your choice: '

dir=ofer1
options=( "TIMER!" "Quit" "Record" "Configuration" "Edit" "fetch" "Wallpaper" "mail"  "blogging" "testing" "github" "Job" )
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

            $dir/timer.sh all
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
