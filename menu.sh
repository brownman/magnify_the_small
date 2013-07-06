#!/bin/bash

pushd `dirname $0` > /dev/null
#. $TIMERTXT_CFG_FILE
#dir=$TIMER2_DIR



PS3="Main Menus"


reset
#echo "$str2"
#cyan  "\t\t\t\t Parent Menu" 
options=("Quit"   "update" "job" "buy" "code" )
select opt in "${options[@]}"
do
    #echo "my status is:"

    case $opt in
        "Quit")
            exiting
            ;;

        "update")
            echo 'update'
            $PWD/menu1.sh
            ;;
     "job")
            echo 'update'
            $PWD/menu4.sh
            ;;
     "buy")
            echo 'update'
            $PWD/menu3.sh
            ;;
     "code")
            echo 'update'
            $PWD/menu2.sh
            ;;


        *)
            exiting
            ;;

    esac
done

popd > /dev/null
exit
