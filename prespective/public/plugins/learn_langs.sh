#!/bin/bash
# about file:
# learn foreign language with the website: 
# http://www.goethe-verlag.com/
# record your steps being done
#./private/old/oldy1/timer.sh:    (xdg-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}0${num}.HTM" &)

. $TIMERTXT_CFG_FILE
#file=$TODAY_DIR/txt/report.yaml
play_lesson(){
    trace "learn langs() $1 $2"

    lesson=${2:-10} #$2
    gxmessage $GXMESSAGET "lesson $lesson"
    lang=$1



    lesson=$( gxmessage -title "Level: $lesson" 'choose a lesson number:' -entrytext $lesson $GXMESSAGET -buttons "ok:$lesson" )
    while :;do
        messageYN1 'continue to next lesson ?'
        result="$?"
        echo -n  "eacher result:"
        green "$result"
        if [[ $result -eq 0 ]];then
            echo 'breaking'
            break
        else
            code1
        fi
    done
}

code1(){

    xterm1 $PLUGINS_DIR/free_speak.sh

    declare -i num


    let "lesson=$lesson+1"



    if [[ $lesson -eq 0 ]];then
        flite 'finish the lesson' 
        break
    fi





    local num=$lesson
    num=num+2
    if [ $SHOW_LESSON = true ];then

        (exo-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}0${num}.HTM" &)
    fi


    num=num-2
    #(write_essay &)
    echo1 'playing..'

    local infile="/TORRENTS/AUDIO/LANGS/${lang}/EN${lang}0${num}.mp3"
    local time_str="$TIME_STR"


    play "$infile" trim ${time_str}

}


$@
#learn_lang "$1" "$2"