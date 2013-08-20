#!/bin/bash
# about file:
# collection of system tasks
# no gui here - remove gxmessage 
# 


export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE


yellow  "tasks.sh got: "
echo2 "1: $1"
echo2 " 2:$2 3:$3 4: $4"


edit(){
local name="$1"
local result=0
local file1=$TODAY_DIR/txt/$name.txt
local file2=$TODAY_DIR/yaml/$name.yaml

gedit $file1 & 
gedit $file2 &
}

motivation(){
arg="$1"

if [ "$arg" = 'glossary' ];then
local word=$( random_line $TODAY_DIR/txt/glossary.txt )
$PLUGINS_DIR/scrap.sh translate "$LANG_DEFAULT" "$word"
sleep1 3
$PLUGINS_DIR/scrap.sh translate 'ar' "$word"
else
$PLUGINS_DIR/translation.sh line $TODAY_DIR/txt/$arg.txt
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
echo "name: $name"
echo "value: $value"

local str="$value"
local file_msg=$CFG_DIR/guidance.txt 
local msg="push forward:"
local title='options'

res=$( string_to_buttons "$str" "$title" "$msg" )
#res=$( string_to_buttons_file "$str" "$title" "$file_msg" )
answer=$?
#cyan "$res"
#yellow "$answer"


if [[ $answer -eq 0 ]];then
echo 'skip editing'
else
gedit $TODAY_DIR/yaml/$res.yaml
fi
}

take_photo(){
$PLUGINS_DIR/take_photo.sh
}

show(){
    echo "show() got: $1 $2"
local name="$1"
local file=$TODAY_DIR/yaml/$name.yaml
touch $file

    string_to_buttons_file 'cancel edit' '2 options' $file
    answer=$?

    if [[ $answer -eq 1 ]];then
        gedit $file
    else
        echo 'skip editing'
    fi
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
#(      xterm -e $PLUGINS_DIR/collaboration.sh &)
$PLUGINS_DIR/collaboration.sh 
#sleep1 30
}

reminder(){
(      xterm -e $PLUGINS_DIR/stop_watch.sh &)
}

game_essay(){
$PLUGINS_DIR/game_essay.sh
}

learn_langs(){
$PLUGINS_DIR/learn_langs.sh $LANG_NAME $LANG_NUM
#RU 13
}



eval "$1" '"$2" "$3"'
