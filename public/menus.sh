#!/bin/bash
#keep this file clean  !



pushd `dirname $0` > /dev/null

export TIMERTXT_CFG_FILE=~/.bash_it/ofer1/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
#export VERBOSE=true
#red "$commitment"
#echo -n "imagine commands: "
#me "translate-"

points=$( cat  "$done_txt" | head -2 ) #points
PS3=$(  log1; yellow "$NAME1 - go on to: " )
#reset

#$PWD/robot.sh
#commitment1 


#cyan  "\t\t\t\t Parent Menu" 

options=("Quit" "Status"  "Job" "Points" )


#yellow "choose:\nEdit .txt\nPlay timer tasks\nUpdate .sh\nContinue to next menu\nQuit"
select opt in "${options[@]}"
do
    #echo "my status is:"



    case $opt in
        "Quit")
            exiting
            ;;

        "Points")
            echo 'increase your points for each break:'
            read answer
            echo $answer >> $done_txt

            cat $done_txt

            ;;
        "Status")
            white 'update points ?'
            sleep1 1
            log2
            sleep1 2
            #$timer_sh remind 
            echo2 "edit .txt files"
            . $TIMER2_DIR/edit.sh
            ;;
        "Job")
            echo 'open: linkin, check mails, etc'
            xdg-open 'http://geekjob.co.il/'


            echo "add idea for efficient job hunting:"
            read answer

            if [ "$answer" != '' ];then
                echo "$answer" >> $job_txt 
            fi
            cat -n $job_txt
            ;;


        *)
            #$timer_sh remind1
            #read


            #reset
            $PWD/menu.sh

            #$timer_sh     learn1
            #exiting

            ;;

    esac
done




popd > /dev/null
exiting



