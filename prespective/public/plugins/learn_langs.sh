#!/bin/bash

# about file:
# learn foreign language with the website: 
# http://www.goethe-verlag.com/
# record your steps being done
#./private/old/oldy1/timer.sh:    (xdg-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}0${num}.HTM" &)

#. $TIMERTXT_CFG_FILE
#file=$TODAY_DIR/txt/report.yaml
trace "DEBUG: $DEBUG"
show_lesson=false #$SHOW_LESSON
path1=/TORRENTS/AUDIO/LANGS
lesson=${2:-10} #$2
lang=$(higher $LANG_DEFAULT)
play_lesson(){
    trace "learn langs() $1 $2"

    trace "lang: $lang"
    gxmessage $GXMESSAGET "lesson $lesson"




    lesson=$( gxmessage -title "Level: $lesson" 'choose a lesson number:' -entrytext $lesson $GXMESSAGET -buttons "ok:$lesson" )

    if [ "$DEBUG" = true ];then
        code1
    else
        while :;do
            messageYN1 'continue to next lesson ?'
            result="$?"
            echo -n  "eacher result:"
            trace "$result"
            if [[ $result -eq 0 ]];then
                echo 'breaking'
                break
            else
                code1
            fi
        done

    fi
}

code1(){
    #xterm1 $PLUGINS_DIR/free_speak.sh
    declare -i num
    let "lesson=$lesson+1"

    if [[ $lesson -eq 0 ]];then
        flite 'finish the lesson' 
        break
    fi

    local num=$lesson
    num=num+2
    #if [ "$show_lesson" = true ];then
        (exo-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}0${num}.HTM" &)
        (exo-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}002.HTM" &)
    #fi


    num=num-2
    #(write_essay &)
    trace 'playing..'

    local infile=$path1/${lang}/EN${lang}0${num}.mp3
    local time_str="$TIME_STR"
    is_valid $infile
    res1=$?

    if [[ $res1 -eq 0 ]];then
        trace 'fail'
        echo 'fail'
    else
        trace 'success'

        play "$infile" trim ${time_str}
        echo 'success'
    fi

    trace "$infile"


}


$@
#learn_lang "$1" "$2"
