#!/bin/bash
# about file:
# plugin:      translation
# description: translate 1 line of text to many languages by choice
. $TIMERTXT_CFG_FILE

help_options="sentance/ line/ lines"
method="$1" #sentance, line, lines
from="$2" #file or sentance
multiple_langs="$3" #false #export MULTIPLE_LANGS=true
silence1=$4
target_lang=$LANG_DEFAULT
dirty_log=true #export DIRTY_LOG=true
silent_fetch=$SILENT_FETCH
silent=$SILENT
echo 'translate.sh got:'
echo "1:$1 2:$2"

play1(){

    echo -n "play1() got: "
    debug trace "$1 | $2"

    if [ "$SILENCE" = false ];then

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
            red 'playing is already on'
            Backtrace1
        fi
    else

        trace    'silent is on'
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

    is_valid $file_txt
    result=$?
    echo -n 'result is: '
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

        is_valid $file_txt
    else

        cat $file_txt
        trace "cache copy"

    fi

    printing1 "$input_ws" "$file_txt" "$lang"
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
            echo -n "$output" | text2wave -o "$file_mp3" #/tmp/1.wav | lame /tmp/1.wav  $file_mp3 
        else
            if [ "$silent_fetch" = true ];then
                trace 'play this mp3 on next run'
                ( wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=${lang}\&q=${output_wsp} > $file_mp3 &) 
            else
                wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=${lang}\&q=${output_wsp} > $file_mp3 
                play1  "$file_mp3" "$lang"
            fi
        fi
        is_valid $file_mp3
    else
        #debug red $result
        trace "cache copy"
        play1  $file_mp3 "$lang"
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

    echo -n "choosen line: "
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

    echo -n "choosen line: "
    trace "$str"
    echo4 "$str" 
}
echo4(){
    trace "echo4() got: $1"
    if [ "$1" = '' ];then
        error_handler 
    fi

    local lang1="$target_lang"
    trace "translate to: $lang1"

    if [ "$lang1" = '' ];then
        random1 4
        local num=$?
        #red "num: $num"
        lang0="${arr1[$num]}"
        lang1=$(lower $lang0)
    fi

    local str="$1"
    trace "$str"

    translate_f  "$str" "en"

    if [ "$dirty_log" = true ];then
        external_file=$TODAY_DIR/txt/log.txt
        update_file $external_file "$str"
    fi

    translate_f  "$str" "$lang1"
}

echo5(){

    #sleep1 3

    #count words in sentence - if lower then 4 - translate_f also to: ar, hi

    local str="$1"


    if [ "$str" = '' ];then

        error_handler
        exiting
    else

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

    fi
}

printing1(){
    local input_ws="$1" 
    local file_txt="$2"
    local lang="$3"

    local line1=`cat $file_txt | head -1`
    local line2=`cat $file_txt | head -2 | tail -1`
    #local line3=$(echo "$line2"|sed 's/ /:1,/g');

    if [ $GUI = true ]
    then
        if [[ $lang = ru  ||  $lang = hi ]];
        then
            notify-send $TIMEOUT_NS "$line1" "$line2"   
        else
            notify-send $TIMEOUT_NS "$line1"
        fi
    fi

    cat -n $file_txt 

    #update_file $log_txt "$line1 | $line2"    
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
    echo ''
}

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
    all_lines "$from"
else
    echo -n   "unknown method:"
    red $1
    help1 "$help_options"
fi
