#!/bin/bash
#-x
# about file:
# parent menu
#



pushd `dirname $0` > /dev/null
. $TIMERTXT_CFG_FILE
PS3=$(  log1; white "$NAME1 - go on to: " )
options=("Quit" "Run_Workflow" "Do_For_Others"  "Act_childish" "Else" )

reset
select opt in "${options[@]}"
do

    case $opt in
        "Quit")
            exiting
            ;;
        "Run_Workflow")
            white 'do you want to increase prespective ?'
            yellow 'the current workflow is:' 
            cyan "Workflow:"
            echo "$workflow"
echo 'run workflow ?'
read answer
if [ $answer = y ]
then

            $SCREENS_DIR/periodic.sh "$workflow"
fi



            ;;

        "Do_For_Others")
            cyan 'update points !'

            $TASKS_DIR/edit.sh
            ;;

        "Act_childish")
            echo 'wana scrap something nice ? '
            green "wana write a new children song and post it ?"
            read answer
            if [ "$answer" = y ];then
                $SCREEN_DIR/motivation.sh
            fi
            ;;
        "Else")
            $MENUS_DIR/menu.sh
            ;;
        *)
            #$timer_sh remind1
            #read


            #reset


            #$timer_sh     learn1
            #exiting

            ;;

    esac
done




popd > /dev/null
exiting



