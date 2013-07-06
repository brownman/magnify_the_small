#!/bin/bash

pushd `dirname $0` > /dev/null
#. $TIMERTXT_CFG_ILE

PS3="Job & Collaboration:"
options=( "Quit" "Collaborate" "Job"  )


reset
white  "config" # | flite
select opt in "${options[@]}"
do

    case $opt in
        "Quit")
            exiting
            ;;
        "Job")
            echo 'open: linkin, check mails, etc'
            ;;

        "Collaborate")
            echo 'update Eran, Boaz'
            ;;

        *)
            echo '*'
            ;;
    esac
done

popd > /dev/null
exit
