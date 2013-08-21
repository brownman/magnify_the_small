#!/bin/bash
# about file:
# plugin:       stop-watch 

. $TIMERTXT_CFG_FILE
timeout=$1

array_to_buttons(){
    #    local str1=''
    local str="$1"
    #local times="$2"
    local title="$2"

    local msg="$3"
    #IFS=' ' read -a array <<< "$1"
    # #echo ${array[@]}
    #
    #    #array=$( echo "$1" )
    #    
    #
    #    for i in "${!array[@]}"; do
    #        if [ "$str1" = '' ];then
    #       str1="${array[$i]}:$i"
    #        else
    #       str1="$str1,${array[$i]}:$i"
    #        fi
    #    done
    #
    #    #echo "$str1"
    #
    #$( gxmessage -buttons "$str1" -title "$3" "$2" $GXMESSAGET )
    string_to_buttons "$str" "$title"
    choose="$?"
    local result=${array[$choose]}
    echo "result: $result"
    echo0 "$result"
    #{array[$choose]}"
    #echo
    if [ $SHOW_SIMILAR_WORDS = true ];then
        scrap_something "$LANG_DEFAULT" "$result"
    fi
}

stop_watch1(){
    echo2 "stop_watch1() got: $1 $2 $3"


    local sec="$1" #500 long
    local every="$2" #60 every 
    local msg="$3" #msg
    local msg1=""
    #echo "sleep ${sec}s"
    local title=''

    #echo0 "$msg"

    for (( c=0; c<=$sec; c++ ))
    do

        #let "m = $c % 60"

        m=$((c%every))
        if [ "$m" -eq 0  ];then
            title="commitment reminder"

            local msg1="$c/$sec:  $msg"

            if [ "$SHOW_BUTTONS" = 'true' ];then
                array_to_buttons "$msg" "$title" "$msg1" 
            else
                string_to_buttons 'exit ok'  "commitment reminder:" "$msg1"
                answer=$?

                if [[ $answer -eq 0 ]];then
                    exiting
                else
                    echo 'go on'
                fi

            fi



        fi
        echo -n "$c "
        sleep 1s
    done

    echo0 "$msg"


    #ref: http://linux.about.com/od/Bash_Scripting_Solutions/a/Arithmetic-In-Bash.htm
}

reminder1(){
    local line=$( gxmessage -entrytext  '500|60|commitment:' -title 'commitment' '5 minutes for the next step:' $GXMESSAGET  )

    if [ "$line" != '' ];then
        local   long=$( echo $line | awk -F '|' '{print $1}' )
        local every=$( echo $line | awk -F '|' '{print $2}' )
        local   msg=$( echo $line | awk -F '|' '{print $3}' )

        stop_watch1 "$long" "$every" "$msg" 
    else
        flite 'no commitments !' 
    fi
}
reminder1 
#exit 

