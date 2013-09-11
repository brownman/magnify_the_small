#!/bin/bash
# about file:
# collection of system tasks
# no gui here - remove gxmessage 
# 


#export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
#. $TIMERTXT_CFG_FILE


trace "tasks.sh got: "  
trace "1: $1"  
trace " 2:$2 3:$3 4: $4"  

#present(){
#    trace "present() got: 1:$1 2:$2"
#    action="$2"
#    title="present:"
#    msg=$($PLUGINS_DIR/yaml_parser.sh fetch "$1")
#    $action "$msg" "$title"
#}
#fetch(){
#    trace "fetch got: $1 $2"
#    local    msg=$($PLUGINS_DIR/yaml_parser.sh fetch "$1")
#    
#    echo "$msg"
#}
#
random_quote(){
local res=$( $PLUGINS_DIR/random_quote.sh)
echo "$res"
}
show_msg(){
    trace "show_msg $1: $2"
    local msg=$(gxmessage $GXMESSAGET "$1" -title "$2" -entry )
    #commitment "$msg"
    echo "$msg"
}
show_msg_entry(){

    #tracex 'show_msg_entry' "show_msg_entry $1: $2"
    local msg=$( gxmessage -entry $GXMESSAGET "$1" -title "$2" )
    if [ "$msg" = '' ];then
        motivation glossary
    else
        trace 'echo 01'



        echo01 "$msg"

        flite "$msg"
    fi

}

string_to_buttons(){
    local res=$($PLUGINS_DIR/string_to_buttons.sh "$1" "$2" "$3")
    echo "$res"
}

write_essay(){
    $PLUGINS_DIR/free_speak.sh
}

nothing(){
    trace "nothing got: $1"
    echo "$1"
}
edit(){
    local name="$1"
    local result=0
    local file1=$TODAY_DIR/txt/$name.txt
    local file2=$TODAY_DIR/yaml/$name.yaml

    gedit $file1 & 
    gedit $file2 &
}
take_photo(){
    xterm1 $PLUGINS_DIR/take_photo.sh
}

motivation(){

sleep1 $motivation_sleeping
    file_name="$1"
    local file=$CFG_DIR/txt/$file_name.txt
    $PLUGINS_DIR/translation.sh line $file false
#    (    show_file $file &)

   
}
scrap(){

    local lang=$1 
    local word=$2 
    local word1=''
    trace "word: $word"


    word1=`echo "$word"`
    $PLUGINS_DIR/scrap.sh translate $lang "$word1" 


}

koan(){
    yellow 'add 1 koan !'
    ( bash -c $KOANS_DIR/meditate.sh &)
}


record_for_later(){
    xdg-open 'http://www.youtube.com/upload'
}


show_file(){

    local    file="$1"

    #string_to_buttons_file 'cancel edit' '2 options' $file
    $(messageYN1 'edit file ?' 'show_file' '-iconic' )
    answer=$?

    if [[ $answer -eq 1 ]];then
        gedit $file

    else
        echo 'skip editing'
    fi

}

show_file_html(){

    local    file="$1"

    string_to_buttons_file 'cancel edit' '2 options' $file
    answer=$?

    if [[ $answer -eq 1 ]];then
        exo-open $file

    else
        echo 'skip editing'
    fi

}

show(){
    trace "show() got: $1 $2"
    local name="$1"

    flite "minimizinged file" # - $name"
    local file=$CFG_DIR/txt/$name.txt
    touch $file
    show_file "$file"

}

time1(){
    date1="$(date +%H:%M)"
    ( gxmessage  -buttons "_$last_task" "time: $date1"  -sticky -ontop -font "serif bold 74" -timeout $TIMEOUT1 &)
    echo4 "$date1"
}

update(){
    cyan "update:"
    title="NOW DOING:"
    file=$now_txt
    add_line $file "$title" true #add time note 
    tile="EFFICIENT COMMITMENT:"
    file=$ideas_txt
    add_line $file "$title"
}


suspend1(){

    local msg=`cat public/cfg/blank.yaml | shyaml get-value frame.should`
    #flite "should - $msg"
    flite 'update your notebook'

    motivation sport
    $PLUGINS_DIR/suspend.sh

}

generate_file(){
    local subject=$1
    local file=$2
    $PLUGINS_DIR/yaml_parser.sh generate_file $subject $file
}

report(){
    echo 'update google blogger with the score for this cycle'
}

collaboration(){
    #(      \'xterm1 $PLUGINS_DIR/collaboration.sh &)
    $PLUGINS_DIR/collaboration.sh 
    #sleep1 30
}

commitment(){
    $PLUGINS_DIR/commitment.sh "$1"  
    #$PLUGINS_DIR/stop_watch.sh 
}

game_essay(){
    $PLUGINS_DIR/game_essay.sh
}

learn_langs(){
        xterm1 $PLUGINS_DIR/learn_langs.sh play_lesson $LANG_NAME $LANG_NUM
}



eval "$1" '"$2" "$3"'


