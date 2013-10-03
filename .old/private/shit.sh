string_to_buttons_file1(){

    tracex "string_to_buttons()  got: 1:$1 2: $2 3:$3 4:$4"
    local str="$1"
    local title="$2"
    local file_msg="$3" 
    local delimeter="$4"

    local str1=''
    if [ "$delimeter" = '' ];then
        trace 'no delimeter found'
        delimeter=' '  
    fi

    #delimeter=${1:-60}   # Defaults to /tmp dir.

    old_IFS=$IFS
    IFS="$delimeter"
    #echo  "ifs: $IFS" >&2
    #cat $file


    read -a array <<< "$str"
    for i in "${!array[@]}"; do
        if [ "$str1" = '' ];then
            str1="${array[$i]}:$i"
        else
            str1="$str1,${array[$i]}:$i"
        fi
    done

    IFS=$old_IFS

    gxmessage $(echo $GXMESSAGET) -title "$title" -buttons "$str1"  -file $file_msg $ICONIC
    choose="$?"

    local str2="${array[$choose]}"
    echo "$str2"

    return $choose
}



string_to_buttons2(){
    tracex "string_to_buttons()  got: 1:$1 2:$2 3:$3 4:$4"
    local str="$1"
    local title="$2"
    local msg="$3" 
    local delimeter="$4"
    local result=0

    local str1=''
    if [ "$delimeter" = '' ];then
        delimeter=' '  
        trace 'no delimeter found'
    fi

    #delimeter=${1:-60}   # Defaults to /tmp dir.

    old_IFS=$IFS
    IFS="$delimeter"
    #echo  "ifs: $IFS" >&2
    #cat $file


    read -a array <<< "$str"
    for i in "${!array[@]}"; do
        if [ "$str1" = '' ];then
            str1="${array[$i]}:$i"
        else
            str1="$str1,${array[$i]}:$i"
        fi
    done

    IFS=$old_IFS
    gxmessage $GXMESSAGET -title "$title" -buttons  "$str1" "$msg"
    result=$?
    #trace "$result"
    #
    #    local str2="${array[$choose]}"
    #    trace "str2: $str2"
    #
    #    trace "choose: $choose"
    #    echo "$str2"
    #
    return $result


motivation(){

    local field="$1"
    if [ "$field" != '' ];then
        $PLUGINS_DIR/translation.sh line $TODAY_DIR/txt/${field}.txt
    else
 #general 
    $PLUGINS_DIR/translation.sh line $TODAY_DIR/txt/motivations.txt
    fi
    #choose5 $STATIC_DIR/reminder.txt
    #choose4 $STATIC_DIR/motivations.txt
    #choose4 $DYNAMIC_DIR/motivation/glossary.txt
    #choose5 $DYNAMIC_DIR/motivation/glossary.txt
    #choose4 $quotes_txt
    #one_tip
}
edit_wish(){
gedit $TODAY_DIR/txt/wish.txt
}
essay_aday(){
echo 'essay aday is the most important product you will have today - believe it is the best tool for your well being'
gedit $TODAY_DIR/yaml/essay_aday.yaml
}

update_statistics(){
    gedit $CFG_DIR/workflow.txt &
}

update_report(){
    #( xterm -e "$TASKS_DIR/blogger.sh" &)
    gedit $TODAY_DIR/txt/report.txt &
}


show_self(){
gedit $CFG_DIR/workflow.txt &
}

edit_prespective(){
achievements(){
gedit $TODAY_DIR/yaml/achievements.yaml &
}


gedit $TODAY_DIR/yaml/3_routes.yaml &
gedit $TODAY_DIR/yaml/priority.yaml &
}

edit_fear(){
gedit $TODAY_DIR/yaml/fear.yaml &
edit1(){
    ( gedit $DYNAMIC_DIR/wish_txt &)
    ( gedit $DYNAMIC_DIR/learn/questions_txt &)
    ( gedit $DYNAMIC_DIR/day/plan.txt &)
}
edit_motivations(){
    ( gedit $TODAY_DIR/txt/motivations.txt &)
    ( gedit $TODAY_DIR/txt/sport.txt &)
}
edit_yaml(){
echo 'edit the prespective file first' 
gedit $TODAY_DIR/yaml/plan.yaml &
gedit $TODAY_DIR/yaml/report.yaml &
gedit $TODAY_DIR/yaml/me.yaml & 
gedit $TODAY_DIR/yaml/breakthrough.yaml & 
}


}
edit_txt(){
edit_stuff
}



}

update_status(){
    echo "what are you doing right now ?"
    read answer

    if [ "$answer" != '' ];then
        spell1 "$answer"
        cyan 'press u to undo'
        read answer2 
        if [ "$answer2" = 'u' ];then
            log2
        else
            time1=$( date | awk -F ' ' '{print $4}' )

            echo "$time1 | $answer" >> $TODAY_DIR/txt/log.txt
            if [ $PROFIT = true ];then
                $PLUGINS_DIR/translation.sh sentence "$answer" 
            fi
        fi
    fi

}
eacher1(){

    echo2  "eacher() got: 1: $1     2: $2"
    local question="$2"
    local command="$1"
    echo -n  "TASK: "
    green "$question"
    eval "$command" 
    sleep1 5
}


take_guidance(){
    ls -1 $STORY_DIR/guidance/*.txt
}

publish_report(){
    $TASKS_DIR/blogger.sh
}

suspend(){
    $tasks_sh suspend
}

scoring(){
    echo 'your scores are: '
    echo -n 'do for others: '
    cyan $POINTS_OTHER_HEART
    echo -n 'taking a real breath and a look around: '
    cyan $POINTS_SUSPEND
    echo -n 'updating statistics:'
    cyan $POINTS_REPORT
    echo -n 'imagine your goals'
    cyan $POINTS_IMAGINE

}



interactive(){
    $tasks_sh motivation
}

make_a_breakthrough(){
    echo 'for doing a breakthrough one must sacrifice'
    echo 'open his heart'
    echo 'give more to others'
}
remind(){
    #echo 'suspension is an opportunity' >> $DYNAMIC_DIR/motivations.txt
    #echo 'the day has already been started - stand up now' >> $DYNAMIC_DIR/motivations.txt
    #echo 'making 1 points per 5 minutes is easy' >> $DYNAMIC_DIR/motivations.txt

    $PLUGINS_DIR/translation.sh $DYNAMIC_DIR/motivations.txt

}
entertainment(){
    echo 'play an mp3 while u gona do a real breakthrough !'
}
deepest_fears(){
    #echo 'confront your deapest fears: escape this cycle' >>  $DYNAMIC_DIR/breakthrough.txt
    #echo 'make a breakthrough' >> $DYNAMIC_DIR/breakthrough.txt
    $PLUGINS_DIR/translation.sh $DYNAMIC_DIR/breakthrough.txt
}
step_a_day(){
    echo 'show result of latest progress in field X'
}



old(){
    #others:
echo ''

    #me:

    #family
    #eacher1
    #$tasks_sh update_report 'write a report'

    #eacher1 publish_report 'publish the report'
    #exiting
    #eacher1 deepest_fears 'what are your deepest fears ?'
    #eacher1 entertainment 'remind of price'
    #eacher1 help1 'show goals'
    #eacher1 step_a_day 'push forward - make 1 step in 1 field'
    #eacher1 scoring 'current status'
    #eacher1 remind 'remind me of the true reasons of what I am doing'

    #eacher1 update_status 'update your state'
    #suspend #30 seconds
}


now(){
$tasks_sh update_report 


}
