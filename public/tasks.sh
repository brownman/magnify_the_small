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

take_photo(){
    echo4 "$last_camera_before" 
    pic_file=$(echo ~/pictures/webcam-$(date +%m_%d_%Y_%H_%M).jpeg)
    ffmpeg -y -r 1 -t 3 -f video4linux2 -vframes 1 -s sxga -i /dev/video0 $pic_file
    echo4 "$last_camera_after" 
    (xloadimage $pic_file &)
    (xloadimage $uml_pic &)
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

suspend(){
    #touch $now_txt
    local elapsed
    take_photo
    #last_commitment=`cat $now_txt | head -1`
    #echo4 "$last_commitment" 
    #echo4 "$msg_suspend" 

    choose5 $DYNAMIC_DIR/motivation/glossary.txt
    local before=`date +%s`
    dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend

    choose4 $DYNAMIC_DIR/wish.txt

    #. $TIMERTXT_CFG_FILE
    local after=`date +%s`

    let elapsed=after-before

    gxmessage -title 'suspend for:'  "$elapsed" $GXMESSAGET

    if [ $elapsed -lt $TIMEOUT1 ];then
        echo4 "let me sleep for at least $TIMEOUT1 seconds"
        suspend
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
    choose4 $DYNAMIC_DIR/wish.txt
    
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



eval $1 '"$2" "$3"'
