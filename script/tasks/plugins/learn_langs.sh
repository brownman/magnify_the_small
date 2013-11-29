#!/bin/bash

# about file:
# learn foreign language with the website: 
# http://www.goethe-verlag.com/
# record your steps being done
#./private/old/oldy1/timer.sh:    (xdg-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}0${num}.HTM" &)

#. $TIMERTXT_CFG_FILE
#file=$TODAY_DIR/txt/report.yaml
path1=$DIR_LEARN_LANGS

lesson=${2:-"$LESSON_NUM"} #$2
lang=$(higher $LANG_DEFAULT)
assert_equal_str "$lesson"
#notify-send "free-speak" "$0"

delay=5
file_locker=/tmp/learn_langs


run(){
    #trace "learn langs() $1 $2"
    #trace "lang: $lang"
    #gxmessage $GXMESSAGET "lesson $lesson"


    #$tasks_sh free_speak learn_langs &

    (exo-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}002.HTM" &)

    lang=$( gxmessage -title "Lang: $lang" 'choose a language :' -entrytext "$lang" $GXMESSAGET -buttons "ok" )

    lesson=$( gxmessage -title "Level: $lesson" 'choose a lesson number:' -entrytext $lesson $GXMESSAGET -buttons "ok:$lesson" )

    if [ !  "$lang" ];then
        exiting
    fi
    if [ !  "$lesson" ];then
        exiting
    fi

    while :;do
        messageYN1 "continue to lesson -$lesson- ?"
        result="$?"
        echo -n  "eacher result:"
        trace "$result"
        if [[ $result -eq 0 ]];then
            echo 'breaking'
            break
        else
            code1

    #xterm1 $PLUGINS_DIR/free_speak.sh
            let "lesson=$lesson+1"
        fi
    done
}

code1(){

    declare -i num


    if [[ $lesson -eq 0 ]];then
        flite 'finish the lesson' 
        break
    fi

    local num=$lesson
    num=num+2
    (exo-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}0${num}.HTM" &)


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

        play "$infile" 
        #trim ${time_str}
        echo 'success'
    fi

    trace "$infile"


}
trace "$@"
unlocker
#$@
#learn_lang "$1" "$2"
