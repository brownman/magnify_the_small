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

present(){
    $PLUGINS_DIR/yaml_parser.sh grab1 "$1"
}


write_essay(){
    $PLUGINS_DIR/free_speak.sh
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
    $PLUGINS_DIR/take_photo.sh
}

motivation(){
    file_name="$1"
    local file=$CFG_DIR/txt/$file_name.txt

    echo "file: $file"
    xterm1 $PLUGINS_DIR/translation.sh line $file 

    #show_file $file
    #sleep 10
}
scrap(){
    local word=$( random_line $CFG_DIR/txt/glossary.txt )
    echo "word: $word"
    if  [ "$word" != '' ] ;then


        xterm1  "$PLUGINS_DIR/scrap.sh" "translate ar '$word'"
        sleep1 10

        xterm1  "$PLUGINS_DIR/scrap.sh" "translate ru '$word'" 
    fi

}

koan(){
    yellow 'add 1 koan !'
    ( bash -c $KOANS_DIR/meditate.sh &)
}


record_for_later(){
    xdg-open 'http://www.youtube.com/upload'
}

take_photo(){
    $PLUGINS_DIR/take_photo.sh
}
show_file(){

    local    file="$1"

    string_to_buttons_file 'cancel edit' '2 options' $file
    answer=$?

    if [[ $answer -eq 1 ]];then
        gedit $file

    else
        echo 'skip editing'
    fi

}


show(){
    echo "show() got: $1 $2"
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
    $PLUGINS_DIR/stop_watch.sh 
    #$PLUGINS_DIR/stop_watch.sh 
}

game_essay(){
    $PLUGINS_DIR/game_essay.sh
}

learn_langs(){
    if [ "$DEBUG" = 'true' ];then

        $PLUGINS_DIR/learn_langs.sh play_lesson $LANG_NAME $LANG_NUM 
    else

        ( 
        xterm1 $PLUGINS_DIR/learn_langs.sh play_lesson $LANG_NAME $LANG_NUM &)
    fi

    #RU 13
}



eval "$1" '"$2" "$3"'


