#!/bin/bash
# about file:
# collection of system tasks
#   
# 
. $TIMERTXT_CFG_FILE

echo2  "tasks.sh got: "
echo2 "1: $1"
echo2 " 2:$2 3:$3 4: $4"

take_photo(){
    echo4 "$last_camera_before" 
    pic_file=$(echo ~/pictures/webcam-$(date +%m_%d_%Y_%H_%M).jpeg)
    ffmpeg -y -r 1 -t 3 -f video4linux2 -vframes 1 -s sxga -i /dev/video0 $pic_file
    echo4 "$last_camera_after" 
    (xloadimage $pic_file &)
}


suspend(){
    local elapsed
    take_photo
    last_commitment=`cat $now_txt | head -1`
    echo4 "$last_commitment" 
    echo4 "$msg_suspend" 

    local before=`date +%s`
    dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend
    local after=`date +%s`
   
    let elapsed=after-before

    gxmessage -title 'suspend for:'  "$elapsed" $GXMESSAGET
    
    if [ $elapsed -lt 20 ];then
    echo4 'let me sleep for at least 20 seconds' 
    suspend
    fi
    
    answer=$( gxmessage -title 'now_txt' -file $now_txt  -entrytext 'my commitment is to '  $GXMESSAGE1 )
    update_file  $now_txt "$answer"



}

translate_f(){
    local silent_fetch=$SILENT_FETCH
    local silent=$SILENT
    local lang="$2"
    echo2 "translate_f() got:"
    echo2 "input: $1 | lang: $2"

    local input="$1" #translate src
    local input_wsp=$(echo "$input"|sed 's/ /+/g');
    local input_ws=$(echo "$input"|sed 's/ /_/g');
    #local  mp3_file=$dir_mp3/${input_ws}_${lang}.mp3

    local file_name=$(  echo $dir_txt/${input_ws}_${lang}.txt )
    local mp3_file=$(  echo $dir_mp3/${input_ws}_${lang}.mp3 )

    local files1=$(ls  $file_name 2> /dev/null )
    local files2=$(ls  $mp3_file 2> /dev/null )
    if [ ! "$files1"  ] #|| [ ! "$files2" ]
    then
        echo2 "fetch txt"
        result=$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$input_wsp&sl=en&tl=$lang" ) 
        cleaner=$(echo "$result" | sed 's/\[\[\[\"//') 
        echo2 "$cleaner"
        phonetics=$(echo "$cleaner" | cut -d \" -f 5)
        output=$(echo "$cleaner" | cut -d \" -f 1)
        output_wsp=$(echo "$output"|sed 's/ /+/g');
        output_ws=$(echo "$output"|sed 's/ /_/g');

        touch "$file_name"
        echo2 "$phonetics"
        echo "$output" >   "$file_name"

        if [  "$lang" = 'ru' ] || [ "$lang" = 'hi' ]
        then 
            echo  "$phonetics" >>   "$file_name"
        fi
    else
        echo2 "cache copy"
    fi
    #echo2 'print the content of the result'
    #cat $file_name 
    if [ "$silent_fetch" = false ];then
        output=`cat $file_name | head -1`
        #blue "fetch for: $output"
        output_wsp=$(echo "$output"|sed 's/ /+/g');
        output_ws=$(echo "$output"|sed 's/ /_/g');
        if [ ! "$files2" ];then
            echo2 'fetch sound'
            if [ "$lang" = 'tl' ]
            then
                echo1 $output
                echo -n "$output" | text2wave -o "$mp3_file" #/tmp/1.wav | lame /tmp/1.wav  $mp3_file 
            else
                ( wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=${lang}\&q=${output_wsp} > $mp3_file \&\& play1  $mp3_file \&)
            fi
        else
            echo2 'no fetch sound'
        fi
    fi

    str=`cat "$file_name" `
    str1=`echo  $str`

    printing1 "$input_ws" "$file_name" "$lang"
    if [ "$silent" = false ];then
        echo1 'play1 !'
        echo1 "play1 $mp3_file" 
        if [ "$silent_fetch" = true ]
        then
            #  ( play1  $mp3_file &)
            echo2 'silent fetch'
        else
            play1  "$mp3_file" "$lang"
        fi

    fi
    #eval "$1=\"$str1\""  # Assign new value.
}


time1(){
    date1="$(date +%H:%M)"
    ( gxmessage  -buttons "_$last_task" "time: $date1"  -sticky -ontop -font "serif bold 74" -timeout $TIMEOUT1 &)
    echo4 "$date1"
}


printing1(){
    local input_ws="$1" 
    local file_name="$2"
    local lang="$3"

    local line1=`cat $file_name | head -1`
    local line2=`cat $file_name | head -2 | tail -1`
    local line3=$(echo "$line2"|sed 's/ /:1,/g');

    if [ $GUI = true ]
    then
        let "r = $RANDOM % 4 "
        color="${color_arr1[$r]}"
        #echo2 "color: $color"
        if [[ $lang = ru  ||  $lang = hi ]];
        then
            notify-send "$line1" "$line2" $TIMEOUT_NS
        else
            notify-send "$line1" $TIMEOUT_NS
        fi
        #( gxmessage "$line1" -buttons "$line3" -sticky -timeout 11 -title "$input_ws"  -geometry 600*900 -font "serif bold 18" -wrap -fg $color $ICONIC &)
    else
        echo '' #  cat $file_name 
    fi
    #echo $file_name
    cat -n $file_name 
    #echo "$input_ws"
}



play1(){
    echo2 "play1() got: $1 | $2"
    if [ $PLAYING_ON = false ];then
        export PLAYING_ON=true
        local lang="$2"
        local lang_repeat=\$"$lang"R   # Name of variable (not value!).
        local times=`eval "expr \"$lang_repeat\" "`
        if [ "$timer" != '' ];then
            local file="$1"
            #declare  -i  counter
            local counter=0
            while [  $counter -lt  $times ]; do
                if [ "$SILENCE" = false ];then
                    play -V1 -q  "$1"
                fi
                (( counter++ ))
            done
        else
            play -V1 -q  "$1"
        fi
        export PLAYING_ON=false
    else
        red 'playing is already on'
        Backtrace1
    fi

}
update(){
    title="update: now_txt"
    file=$now_txt
    add_line $file "$title" true #add time note 


    #title="update: ideas_txt"
    #title="update: ideas_txt"
    tile="efficiency breakthrough:"
    file=$ideas_txt
    add_line $file "$title"
}


motivation_random(){
    choose4 $motivations_txt
    choose4 $quotes_txt
    one_tip
}

one_tip(){
    desc='open website ?'
    url='http://www.mamalisa.com/?t=ec&p=981&c=150'
    command="xdg-open $url"
    eacher "$command" "$desc"
    
    desc='open website ?'
    url='http://mywiki.wooledge.org/BashFAQ'
    command="xdg-open $url"
    eacher "$command" "$desc"
}

show(){

    gxmessage -title 'show: current TEST' -file $TMP_DIR/test.txt $GXMESSAGET
    sleep1 20
    gxmessage -title 'show: morning reminder' -file $STORY_DIR/morning.txt $GXMESSAGET
    gxmessage -title 'show: plan a day' -file $CFG_DIR/earth.txt $GXMESSAGET
    gxmessage -title 'show: project goals' -file $CFG_DIR/project.txt $GXMESSAGET
    gxmessage -title 'show: timer workflow' -file $CFG_DIR/workflow.txt $GXMESSAGET
}

glossary_reminder(){
    word=$(    gxmessage -title 'glossary reminder' -file $STORY_DIR/glossary.txt $GXMESSAGET -entry )
    echo5 "$word"
    choose5 $STORY_DIR/glossary.txt
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


#
#export -f suspend1


#export -f translate_f 
#export -f time1 
#export -f input_line 

#eval '$1 "$2" "$3" "$4" "$5" '
#eval echo \${$n}
$1 "$2" "$3" "$4" "$5" 
