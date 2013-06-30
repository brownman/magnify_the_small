#!/bin/bash

pushd `dirname $0` > /dev/null
. $TIMERTXT_CFG_FILE
dir=$TIMER2_DIR

#str3=`echo -n 'NOW: '; cat  "$todo_txt" | head -2 | awk -F '|' '{print $2}' `

str3=`echo   ''; cat  "$todo_txt" | head -2`
str6=$( date | awk -F ' ' '{print $4}' )
str5=`cat  "$timing_txt"  `
#str33=`cat  "$todo_txt" | head -2 | tail -1`

str4=`echo   ''; cat  "$done_txt" | head -2`

str1=""
str2=$(white "\t\t\t\t $str6";  yellow "$str4"; green "$str3"; red "$str5"; )
PS3="$str2"


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
