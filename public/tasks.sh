#!/bin/bash
# about file:
# collection of system tasks
# no gui here - remove gxmessage 
# 


#export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE


echo  "tasks.sh got: "  >&2
echo "1: $1"  >&2
echo " 2:$2 3:$3 4: $4"  >&2



recent(){
    #trace "recent: $1"
    local subject="$1"

    local str='edit mini action' 

    #local title="$subject: recent task:"

    local title=$(parse_time $subject)
    local msg=$(parse_msg $subject)
    echo0 "$msg" 

    local cmd=$(string_to_buttons "$str" "$title" "$msg" )
    if [ "$cmd" != '' ];then

        trace "num: $?"
        echo "cmd: $cmd"

        #local answer=$?

        #debug "$answer"


        eval "do_$cmd" "$subject"

    fi

}




edit(){
    local name="$1"
    local result=0
    local file1=$TODAY_DIR/txt/$name.txt
    local file2=$TODAY_DIR/yaml/$name.yaml

    gedit $file1 & 
    gedit $file2 &
}

motivation(){
    file_name="$1"
    local file=$CFG_DIR/txt/$file_name.txt

    echo "file: $file"
    $PLUGINS_DIR/translation.sh line $file 
    show_file $file
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

chooser(){
    local name="$1"
    local value=$( eval echo \$$name )
    #echo "name: $name"
    #echo "value: $value"

    local str="$value"

    #local msg=`cat $TODAY_DIR/yaml/network.yaml | head -1`
    #local file_msg=$CFG_DIR/blank.yaml


    #local msg=`cat public/cfg/blank.yaml | shyaml get-values frame.time`
    local title=`cat public/cfg/blank.yaml | shyaml get-value frame.doing`

    local msg=`cat public/cfg/blank.yaml | shyaml get-value frame.time`

    local msg1=`cat public/cfg/blank.yaml | shyaml get-value frame.should`

    #`cat $TODAY_DIR/yaml/network.yaml | head -1`
    #
    #    local title='Timing - where am I ?'
    #    #3 routes: job / we / study'
    #    local msg2=$( spell2 "$msg")
    #    local result=$?
    #    trace "result: $result"
    #    if [[ $result -eq 0 ]];then
    #        echo0 "$msg"
    #    else
    #        flite 'error on spelling' 
    #        echo "$msg2"
    #    fi
    #res=$( string_to_buttons_file "$str" "$title" "$file_msg" )
    res=$( string_to_buttons "$str" "$title" "$msg: $msg1" )

    answer=$?
    #
    #        if [[ $answer -eq 0 ]];then
    #            echo 'skip editing'  >&2
    #        else
    #            #gedit $TODAY_DIR/yaml/$res.yaml
    #
    #        fi
    #
    echo "$res"
}
tasker(){
    pick='routes.we.tasks.easiest'


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

        sleep1 20
    else
        echo 'skip editing'
    fi

}


show(){
    echo "show() got: $1 $2"
    local name="$1"

    flite "minimizinged file - $name"
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



wish(){
    echo -n 'to be implemented: '
    blue "$1"
}

act(){
    yellow "act() got: 1: $1 | 2: $2 | 3: $3"
    #eval '$1 "$2" "$3"'
    #eacher "$1"
}

suspend1(){

    local msg=`cat public/cfg/blank.yaml | shyaml get-value frame.should`
    #flite "should - $msg"
    flite 'update your notebook'

    motivation sport
    $PLUGINS_DIR/suspend.sh







}

is_valid1(){
    file="$1"
    is_valid "$file"
    yellow "$?"
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
    (      xterm1 $PLUGINS_DIR/stop_watch.sh &)
    #$PLUGINS_DIR/stop_watch.sh 
}

game_essay(){
    $PLUGINS_DIR/game_essay.sh
}

learn_langs(){
    if [ "$DEBUG" = 'true' ];then

        $PLUGINS_DIR/learn_langs.sh play_lesson $LANG_NAME $LANG_NUM 
    else

        ( xterm1 $PLUGINS_DIR/learn_langs.sh play_lesson $LANG_NAME $LANG_NUM &)
    fi

    #RU 13
}



eval "$1" '"$2" "$3"'

