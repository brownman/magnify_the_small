#!/bin/bash
# about file:
# collection of system tasks
# no gui here - remove gxmessage 
# 


. $TIMERTXT_CFG_FILE


blue  "tasks.sh got: "
echo2 "1: $1"
echo2 " 2:$2 3:$3 4: $4"
koan(){
    yellow 'add 1 koan !'
    ( bash -c $KOANS_DIR/meditate.sh &)
}


edit(){
    ( gedit $DYNAMIC_DIR/wish_txt &)
    ( gedit $DYNAMIC_DIR/learn/questions_txt &)
    ( gedit $DYNAMIC_DIR/day/plan.txt &)
}
remind(){
    msg='there is only 1 way to go'
    rainbow "$msg"


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

    #title="update: ideas_txt"
    #title="update: ideas_txt"
    tile="EFFICIENT COMMITMENT:"
    file=$ideas_txt
    add_line $file "$title"
}


motivation(){
    #choose5 $STATIC_DIR/reminder.txt
    #choose4 $STATIC_DIR/motivations.txt

    #choose4 $DYNAMIC_DIR/motivation/glossary.txt
    #choose5 $DYNAMIC_DIR/motivation/glossary.txt
    $PLUGINS_DIR/translation.sh
    
    #choose4 $quotes_txt
    #one_tip
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

delete_files(){
    dir=$TMP_DIR/daily
    dir1=$TMP_DIR/essays
    for I in $(ls -1 --sort=time $dir/*.txt )
    do 
        blue 'press ESC to ignore '
        answer=2
        cat $I
        if [ "$answer" = 2 ];then
            echo '' > "$I"
            red 'clean file'
        else
            green 'ignore file'
        fi
    done
    for I in $(ls -1 --sort=time $dir1/*.txt )
    do 
        answer=2
        cat $I
        if [ "$answer" = 2 ];then

            echo '' > "$I"
            red 'clean file'
        else
            green 'ignore file'
        fi
    done
}


wish(){
echo -n 'to be implemented: '
blue "$1"
}


scrap_practice(){
    cyan "idea for practive scraping"
    local title='scraping idea ?'
    while :;do
        answer=$( gxmessage  -buttons "ok"  -entry -title "$title"  -file  $scrap_txt -ontop -timeout $TIMEOUT1 )
        if [ "$answer" = '' ];then
            break
        else 
            update_file $scrap_txt "$answer"
        fi
    done
}

act(){
    yellow "act() got: 1: $1 | 2: $2 | 3: $3"
#eval '$1 "$2" "$3"'
#eacher "$1"
}
suspend(){
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



eval "$1" '"$2" "$3"'
