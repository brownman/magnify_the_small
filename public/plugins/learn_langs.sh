#!/bin/bash
# about file:
# learn foreign language with the website: 
# http://www.goethe-verlag.com/
# record your steps being done
#./private/old/oldy1/timer.sh:    (xdg-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}0${num}.HTM" &)

export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
file=$TODAY_DIR/txt/report.yaml
learn_lang(){
    echo2 "learn_lang() got: $1 $2"
    #say1 "$last_essay" 

    lang=$1
    declare -i num
    lesson=$2
    num=$lesson
    num=num+2
    (xdg-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}0${num}.HTM" &)

    num=num-2
    #(write_essay &)
    echo1 'playing..'

    infile="/TORRENTS/AUDIO/LANGS/${lang}/EN${lang}0${num}.mp3"
play $infile trim 0:00 =0:25 

}

play_history(){
    lang1=$(lower $lang)
    echo1 $lang1
    #ls -1 --sort=time /tmp/bash_koans/txt/*.txt | grep -E "($lang1.txt|it.txt)"
    #exit

    for I in $(ls -1 --sort=time /tmp/bash_koans/txt/*.txt | grep -E "($lang1.txt|it.txt)")
    do 
        str1=$(echo $I | sed 's/txt/mp3/g' ) #| sed 's/word_//g')


        files=$(ls  $str1 2> /dev/null )

        if [[  "$files"  ]]
        then
            (say1 "$str1" &)
            gxmessage  -buttons "_$last_task" -nearmouse -wrap -title "title"  -file $I -font "serif bold 34" -sticky
            echo1 "txt file: $I"


        fi

    done
}

learn_lang "$1" "$2"
