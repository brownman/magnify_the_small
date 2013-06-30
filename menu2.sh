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
options=( "Quit" "imagine" "listen" )


reset
blue  "imagine" # | flite
select opt in "${options[@]}"
do

    case $opt in
        "imagine")
            lang=$( gxmessage "which language?" -entry -timeout 10 )
            #lang options: ru , it , hi , tl , ar  
            $dir/timer.sh write_essay $lang

            $dir/timer.sh send_essay $lang
            ;;

        "listen")
        
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

        "Quit")
            exiting
            ;;

        *)
            reset
            echo 'LET ME IN !' 
            ;;
    esac
done

popd > /dev/null
exit
