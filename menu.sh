#!/bin/bash

pushd `dirname $0` > /dev/null
. $TIMERTXT_CFG_FILE
dir=$TIMER2_DIR

#str3=`echo -n 'NOW: '; cat  "$todo_txt" | head -2 | awk -F '|' '{print $2}' `


PS3="choose: "


reset
#echo "$str2"
cyan  "\t\t\t\t Parent Menu" 
options=(  "update" "imagine" "do!" "config" "quit" )
select opt in "${options[@]}"
do
    #echo "my status is:"

    case $opt in
        "quit")
            exiting
            ;;

        "update")
            echo 'update'
            ./menu1.sh
            reset
            ;;

        "imagine")
            echo 'imagine'
            ./menu2.sh

            ;;


        "do!")
            echo 'do!'
            ./menu3.sh
            ;;
      "config")
            echo 'config'
            ./menu4.sh
            ;;


        *)
            exiting
            echo 'LET ME IN !' 
            ;;

    esac
done

popd > /dev/null
exit
