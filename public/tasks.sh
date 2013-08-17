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
reminder(){
    #recent_progress
    #last_step
echo  'show progress in a field'
echo 'show buttinns'
"does 1 tiny step aday - is equal to a nice huge step a month ?"
rainbow "$remind1" 
rainbow "$remind2" 
}

edit(){
arg="$1"
gedit $TODAY_DIR/txt/$arg.txt
}

motivation(){
arg="$1"
$PLUGINS_DIR/translation.sh line $TODAY_DIR/txt/$arg.txt
}

koan(){
    yellow 'add 1 koan !'
    ( bash -c $KOANS_DIR/meditate.sh &)
}


record_for_later(){
xdg-open 'http://www.youtube.com/upload'
}

remind(){
    msg='there is only 1 way to go'
    rainbow "$msg"
}

take_photo(){
$PLUGINS_DIR/take_photo.sh
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



update_glossary(){
    sleep1 10
    cyan "update:"
    title="my Children story:"
    file=$TODAY_DIR/txt/log.txt
    max=5
    for (( c=1; c<=$max; c++ ))
    do
        echo -n "counter: "
        cyan "$c of $max"
        $PLUGINS_DIR/logger.sh add_line "$file" "$title" 'true'
    done
    #'http://www.cyberciti.biz/faq/bash-for-loop/'
}

show(){
    cyan "show:"
    gxmessage -title 'show: morning reminder' -file $DYNAMIC/wish.txt $GXMESSAGET
}



glossary_reminder(){
    word=$(    gxmessage -title 'glossary reminder' -file $DYNAMIC_DIR/glossary.txt $GXMESSAGET -entry )
    echo5 "$word"
    choose5 $DYNAMIC_DIR/glossary.txt
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
(      xterm -e $PLUGINS_DIR/stop_watch.sh "$line" &)
sleep1 30
}

commitment(){
    local line=$( gxmessage -entry -title 'commitment' '5 minutes for the next step:' $GXMESSAGET  )
    if [ "$line" != '' ];then
        (      xterm -e $PLUGINS_DIR/stop_watch.sh "$line" &)
    else
       echo 'no commitments !' | flite
    fi
}

game_essay(){
$PLUGINS_DIR/game_essay.sh
}

learn_langs(){
#LANG_NAME
#LANG_NUM
$PLUGINS_DIR/learn_langs.sh $LANG_NAME $LANG_NUM
#RU 13
}


eval "$1" '"$2" "$3"'
