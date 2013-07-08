#!/bin/bash
#keep this file clean  !



pushd `dirname $0` > /dev/null

export TIMERTXT_CFG_FILE=~/.bash_it/ofer1/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
#export VERBOSE=true

pids(){
    PIDS=$(pidof sh $0)  # Process IDs of the various instances of this script.
    P_array=( $PIDS )    # Put them in an array (why?).
    #echo "$PIDS"           # Show process IDs of parent and child processes.
    let "instances = ${#P_array[*]} - 1"  # Count elements, less 1.
    # Why subtract 1?
    #echo "$instances instance(s) of this script running."
}


motivation(){
    cat -n $motivations_txt
    echo "add motivation:"
    #everything is funny actualy"
    read answer

    if [ "$answer" != '' ];then
        echo "$answer" >> $motivations_txt 
    fi
    #cat -n $motivations_txt


}
commitment1(){

    str6=$( date | awk -F ' ' '{print $4}' )
    echo -n "dear:  "
    green "$NAME1"
    echo -n "the time is: "
    red "$str6"
    echo -n  "you commited to the next obligation:  "
    str=`cat  $commitment_txt | head -1`
    yellow "$str"


    #$timer_sh  translate  "$str" "it"  
    #$timer_sh  translate  "$str" "ru"  
    #$timer_sh  translate  "$str" "tl"  
    #$timer_sh  translate  "$str" "ar"  
    #$timer_sh  translate  "$str" "ru"  
    #( echo "$str" | flite &)

    #"until X i finish doing Y and start doing Z"
    cyan 'update commitment ?'
    ( echo4 "$str" &)
    read answer
    if [ "$answer" = 'y' ];then


        cyan 'until:'
        read x
        cyan 'I finish doing:'
        read y
        cyan 'and start doing:'
        read z

        if  [ "$x" != '' ]     && [ "$y" != '' ]    && [ "$z" != '' ] 
        then
            echo "until $x - I finish  $y - and start  $z" > $commitment_txt
            exiting
        else
            echo 'error on input'
            exiting
        fi
    elif [ "$answer" = 'n' ];then

        red "Must log in to continue ?"

        read        answer
        if [  $answer = y ];then

            green "$NAME1 is commited ! "
        else

            $timer_sh suspend
        fi
    else
        exiting

    fi


}


points=$( cat  "$done_txt" | head -2 ) #points
PS3=$(  log1; yellow "$NAME1 - go on to: " )
reset
commitment1 
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


            reset
            $PWD/menu.sh

            #$timer_sh     learn1
            #exiting

            ;;

    esac
done




popd > /dev/null
exiting



