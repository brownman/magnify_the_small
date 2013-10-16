#!/bin/bash
# about file:
# plugin:      translation
# description: translate 1 line of text to many languages by choice
#. $TIMERTXT_CFG_FILE
file_locker=/tmp/translation
help_options="sentance/ line/ lines"
method="$1" #sentance, line, lines
from="$2" #file or sentance
multiple_langs=${3:-'true'} #"$3" #false #export MULTIPLE_LANGS=true
silence=${4:-"$SILENCE"} #"$3" #false #export MULTIPLE_LANGS=true
#notify-send
#trace "$silence : silence"

language_of_the_day=$LANG_DEFAULT
dirty_log=true #export DIRTY_LOG=true
silence_fetch=$SILENCE_FETCH

delay=3
gentle=true

trace 'translate.sh got:'
trace "1:$1 2:$2"

#update_file $file_log "-__"    
fetch_html(){
    is_valid "$file_html"
    result=$?
    trace 'result is: '
    trace $result
    if [[ $result -eq 0  ]];
    then
        trace "fetch html"
        if [ "$lang" = 'ru' ]|[ "$lang" = 'ar' ];then
            $tasks_sh scrap "$lang" "$input"
            $tasks_sh show_file_html $file_html
        fi
    else
        $tasks_sh show_file_html $file_html
        trace "cache copy"
    fi
}
make_assosiation(){
    local str="$1"

    local ass=$(gxmessage -entrytext "$str|$LANG_DEFAULT|" -title "sound like:"  -file $file_assosiation $GXMESSAGET -iconic )
    if [ "$ass" != '' ];then

        echo "$ass" >> $file_assosiation
    fi

}
play1(){

    trace "play1() got: "
    trace "$1 | $2"

    if [ "$silence" = false ];then

        local file="$1"

        if [ $PLAYING_ON = false ];then
            export PLAYING_ON=true
            local lang="$2"
            local lang_repeat=\$"$lang"R   # Name of variable (not value!).
            local times=`eval "expr \"$lang_repeat\" "`
            if [ "$timer" != '' ];then

                #declare  -i  counter
                local counter=0
                while [[  $counter -lt  $times ]]; do
                    play -V1 -q  "$1"
                    (( counter++ ))
                done
            else
                play -V1 -q  "$1"
            fi
            export PLAYING_ON=false
        else
            trace 'playing is already on'
            Backtrace1
        fi
    else

        trace    'silence is on'
        trace 'skip playing'
    fi

}


translate_f(){

    ################################# result: txt 
    trace "translate_f() got:"
    trace "input: $1 | lang: $2"


    local lang="$2"

    local input=$(remove_trailing "$1")
    #local input="$1" #translate src




    local input_wsp=$(echo "$input"|sed 's/ /+/g');
    local input_ws=$(echo "$input"|sed 's/ /_/g');

    local file_txt=$(  echo $dir_txt/${input_ws}_${lang}.txt )
    local file_mp3=$(  echo $dir_mp3/${input_ws}_${lang}.mp3 )
    local file_html=$(  echo $dir_html/${input_ws}_${lang}.html )

    is_valid $file_txt
    result=$?
    trace 'result is: '
    trace $result
    if [[ $result -eq 0  ]];
    then
        trace "fetch txt"
        result=$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$input_wsp&sl=en&tl=$lang" ) 
        #echo "$result" >> $TODAY_DIR/translate.json
        cleaner=$(echo "$result" | sed 's/\[\[\[\"//') 
        #trace "$result"
        phonetics=$(echo "$cleaner" | cut -d \" -f 5)
        output=$(echo "$cleaner" | cut -d \" -f 1)
        output_wsp=$(echo "$output"|sed 's/ /+/g');
        output_ws=$(echo "$output"|sed 's/ /_/g');

        #touch "$file_txt"
        echo "$output" >   "$file_txt"

        if [  "$lang" = 'ru' ] || [ "$lang" = 'hi' ]
        then 
            echo  "$phonetics" >>   "$file_txt"
        fi
        cat $file_txt

        #is_valid $file_txt
    else

        cat $file_txt
        trace "cache copy"

    fi

    printing1  "$file_txt" "$lang"

    ################################# result: html 
    #fetch_html

    ################################# result: mp3 
    output=`cat $file_txt | head -1`
    #blue "fetch for: $output"
    output_wsp=$(echo "$output"|sed 's/ /+/g');
    output_ws=$(echo "$output"|sed 's/ /_/g');
    is_valid $file_mp3
    result=$?
    if [[ $result -eq 0 ]];then
        trace 'fetch sound'
        if [ "$lang" = 'tl' ]
        then
            trace $output
            #trace "$output" | text2wave -o "$file_mp3" #/tmp/1.wav | lame /tmp/1.wav  $file_mp3 
        else
            if [ "$silence_fetch" = true ];then
                trace 'play this mp3 on next run'
                ( wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=${lang}\&q=${output_wsp} > $file_mp3 &) 
            else
                wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=${lang}\&q=${output_wsp} > $file_mp3 
                play1  "$file_mp3" "$lang"
            fi
        fi
        #is_valid $file_mp3
    else
        #trace $result
        trace "cache copy"
        if [ "$lang" = 'tl' ]
        then
            trace 'no tl audio'
        else

            play1  $file_mp3 "$lang"
        fi


    fi

}




choose5(){
    trace "choose5() got: $1"

    local file=$1
    local files1=$(ls  $file 2> /dev/null )
    if [ ! "$files1" ];then
        error_handler 
    fi


    local str=`cat $file | sort --random-sort | head -n 1`

    trace "choosen line: "
    trace "$str"
    echo5 "$str" 
}


choose4(){
    trace "choose4() got: $1"

    local file=$1
    local files1=$(ls  $file 2> /dev/null )
    if [ ! "$files1" ];then
        error_handler 
    fi

    local str=`cat $file | sort --random-sort | head -n 1`

    trace "choosen line: "
    trace "$str"

    echo4 "$str" 
}
speller(){
    local ans=$(spell2 "$str")
    local result=0


    if [ "$ans" = "error" ];then

        trace "$ans"
        notify-send "Mis-spelling:" "$ans"
        flite 'spelling error'
        flite 'returning'
        result=1
    fi

    return $result

}

echo5(){

    #sleep1 3

    #count words in sentence - if lower then 4 - translate_f also to: ar, hi

    local str="$1"


    if [ "$str" = '' ];then

        error_handler
        exiting
    fi

    speller "$str"
    if [[ $? -eq 1 ]];then
        return 
    fi
    num=`echo "$str" | wc -w`



    translate_f  "$str" en 
    #echo "$str" | flite
    sleep1 2
    translate_f  "$str" it 
    sleep1 2
    translate_f  "$str" ru 
    sleep1 2
    translate_f  "$str" ar 
    if [ $num -lt 4 ];then
        sleep1 2
        translate_f  "$str" hi 

        sleep1 2
        translate_f  "$str" tl 
    else
        echo 'more then 4 words -> skip playing hi,tl'
    fi

}


random_language(){

    random1 10
    local ans=$?
    if [ $ans -eq 0 ];then
        language_of_the_day="AR"
    elif [ $ans -eq 1 ];then
        language_of_the_day="HI"
    elif [ $ans -eq 2 ];then
        language_of_the_day="IT"
    elif [ $ans -eq 3 ];then
        language_of_the_day="TA"
    fi

}


echo4(){
    trace "echo4() got: $1"


    if [ "$1" = '' ];then
        error_handler 
    fi

    speller "$1"

    if [[ $? -eq 1 ]];then
        return
    fi

#random_language

#    notify-send 'random lang?'  "$?"
    local lang1="$language_of_the_day"
    trace "translate to: $lang1"

    if [ "$lang1" = '' ];then
        random1 4
        local num=$?
        #trace "num: $num"
        lang0="${arr1[$num]}"
        lang1=$(lower $lang0)
    fi

    local str="$1"
    trace "$str"

    num=`echo "$str" | wc -w`
    if [[ $num -gt 1 ]];then
        if [ "$STRING_TO_BUTTONS" = true ];then
                local pick_word=$( $tasks_sh string_to_buttons "'$str'" )
                if [ $pick_word != '' ];then
                    translate_f  "$pick_word" "$lang1"
                    make_assosiation "$pick_word"
                fi
            fi
    else
        #notify-send 'scrap here..'
        trace 'scrap here..'

        #fetch_html
    fi


    translate_f  "$str" "en"


    sleep1 2 

    translate_f  "$str" "$lang1"

    sleep1 2
    translate_f  "$str" "$lang1"

}
printing1(){
    #local input_ws="$1" 
    local file_txt="$1"
    local lang="$2"

    local line1=`cat $file_txt | head -1`
    local line2=`cat $file_txt | head -2 | tail -1`
    #local line3=$(echo "$line2"|sed 's/ /:1,/g');


    if [ "$SILENCE" = true ];then
        if [ "$lang" = ru ];then
            notify-send $TIMEOUT_NS "$line2" "$line1"   
        fi
    else
        if [[ "$lang" = he  ||  "$lang" = hi ]];
        then
            notify-send $TIMEOUT_NS "$line2" "$line1"   
        else
            notify-send $TIMEOUT_NS "$line1"
        fi

    fi



    #    if [ "$dirty_log" = true ];then
    #        update_file $file_log "- $line1 | $line2"    
    #    fi
}


one_line(){
    local file="$1"
    #choose5 $STATIC_DIR/reminder.txt
    #choose4 $STATIC_DIR/motivations.txt

    #choose4 $DYNAMIC_DIR/motivation/glossary.txt
    #choose5 $DYNAMIC_DIR/motivation/glossary.txt
    if [ "$multiple_langs" = true ];then
        if [ "$file" != '' ];then
            choose5 "$file"
        else
            choose5 $CFG_DIR/quotes.txt
        fi

        #one_tip
    else
        if [ "$file" != '' ];then
            choose4 "$file"
        else
            choose4 $CFG_DIR/quotes.txt
        fi

        #one_tip
    fi

}

all_lines(){
    #lines=() 
    local from="$1"
    local cmd='echo4'
    file_to_lines "$from"

    execute_lines
    #local msg=$(    execute_lines )
    #local msg=$(file_to_lines "$from")
    echo "$msg"
    echo "zz"

}


run(){
    local result=''
    #motivation "$file"
    if [ "$method" = 'sentence' ];then
        if [ "$multiple_langs" = true ];then
            echo5 "$from" 
        else
            echo4 "$from" 
        fi
    elif [ "$method" = 'line' ];then
        one_line "$from"
    elif [ "$method" = 'lines' ];then

        #result=$(
        all_lines "$from"
        ##result=$(all_lines "$from")
        echo "$result"
    else
        trace   "unknown method:"
        help1 "$help_options"
    fi
}
unlocker true
#5 true 
