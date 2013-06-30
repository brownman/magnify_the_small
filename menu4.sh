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
options=( "Quit" "Job" "Delete"  "Cfg")


reset
white  "config" # | flite
select opt in "${options[@]}"
do

    case $opt in

        "Job")
            echo 'open: linkin, check mails, etc'
            ;;


        "Delete")
            echo 'delete txt files'
            $dir/timer.sh delete
            ;;
        "Cfg")
            vi $dir/cfg/timer.cfg
            ;;
       "Quit")
            exiting
            ;;
        *)
            echo '*'
            ;;
    esac
done

popd > /dev/null
exit
