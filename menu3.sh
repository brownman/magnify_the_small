#!/bin/bash

pushd `dirname $0` > /dev/null
#. $TIMERTXT_CFG_FILE

PS3="DEAL scraping:"
options=( "Quit" "scraping" "testing" )


reset
select opt in "${options[@]}"
do

    case $opt in

        "Quit")

            exiting
            ;;
        "scraping")
            echo 'google forms + xpath'
            ;;

        "testing")
            $TIMER2_DIR/meditate.sh
            ;;
        *)
            reset
            ;;
    esac
done

popd > /dev/null
exit

