#!/bin/bash
# about file:
# learn foreign language with the website: 
# http://www.goethe-verlag.com/
# record your steps being done
#./private/old/oldy1/timer.sh:    (xdg-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}0${num}.HTM" &)

. $TIMERTXT_CFG_FILE
#file=$TODAY_DIR/txt/report.yaml
learn_lang(){
    trace "learn langs() $1 $2"
    local lesson=${2:-10} #$2
    local lang=$1
    declare -i num

    lesson=$( gxmessage -title "Level: $lesson" 'choose a lesson number:' -entrytext $lesson $GXMESSAGET $ICONIC )
    while :;do



    let "lesson=$lesson+1"



    if [[ $lesson -eq 0 ]];then
        flite 'finish the lesson' 
        break
    fi


                


    local num=$lesson
    num=num+2
   if [ $SHOW_LESSON = true ];then
    (xdg-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}0${num}.HTM" &)
   fi


    num=num-2
    #(write_essay &)
    echo1 'playing..'

    local infile="/TORRENTS/AUDIO/LANGS/${lang}/EN${lang}0${num}.mp3"
    local time_str="$TIME_STR"


     play "$infile" trim ${time_str}
    done
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
