#!/bin/bash 
#-x

#local tts:
#http://leb.net/pub/blinux/doc/blinux/my-tts-linux.txt
#http://wiki.bash-hackers.org
# spawn.sh
#http://tldp.org/LDP/abs/html/internal.html
#pids
green() {
    echo -e "\033[32m$1\033[0m"
}

red() {
    echo -e "\033[31m$1\033[1m"
}
yellow() {
    echo -e "\033[33m$1\033[0m"
}
blue() {
    echo -e "\033[34m$1\033[0m"
}
echo1(){
echo -n  '_'
}
echo2(){

caller 0
green "$1"
red "$2"
blue ""
}


exiting(){
echo1 'exiting'
exit
}
color_arr1=( blue green red black )
echo1 'help: ofer.sh -l X true -> generate article'
echo1 'help: ofer.sh it something  -> generate regular translation and sound'
echo1 'help: ofer.sh -l x false false file false'

num=`pidof -x ofer.sh`
num1=`pidof -x ofer.sh | wc -w`
echo1 "$num"
echo1 "$num1"
if [ $num1 -gt 2 ]; then 

    echo1 "More than 1"
    exit 1 
fi

pushd `dirname $0` > /dev/null
echo1 "Only one; doing whatever..."
echo1 'purpose: deel only with outputs , dont update wallpaper'
echo1 "ofer.sh got: $2"
echo1 "$0"
echo1 "RUN ofer.sh $1 $2"
background=/tmp/static.png

PIDS=$(pidof sh $0)  # Process IDs of the various instances of this script.
P_array=( $PIDS )    # Put them in an array (why?).
echo1 "$PIDS"           # Show process IDs of parent and child processes.
let "instances = ${#P_array[*]} - 1"  # Count elements, less 1.
# Why subtract 1?
echo1 "$instances instance(s) of this script running."
echo1 "[Hit Ctl-C to exit.]"; echo1

if [  "$1" ]
then
    echo1 "param exist $1"
else
    echo1 "no first  param $1 exising!"
    exit
fi
#missions:
#echo1 "ofer.sh run with" "$2"


word=$(echo "$1")
echo1 "$word"

if [ "$2" = "" ]
then

    many='-l'
else
    many=$2
fi

if [ "$3" = "" ]
then
    #gxmessage 'no third arg'
    #./custom/ofer1/translate.sh -l

    #'I like my dogs very much' 

    article=false
    silent=false
    silent_msg=false
    file_to_update=/tmp/tmp.txt
    silent_fetch=false
    push_top=false
else

    article=$3
    silent=$4
    silent_msg=$5
    file_to_update=$6
    silent_fetch=$7
    push_top=$8


fi

echo1 "translate.sh got: ||        str_from? $word    |     many? $many  |   article? $article    |     silent? $silent   |   silent_msg? $silent_msg   |     file_to_update? $file_to_update | silent_fetch? $silent_fetch | push_top?  $push_top"
update_google='false'
#silent='false'
service='google'

#many_images='false'
#~/tmp/ofer/essay.txt










mkdir -p /tmp/bash_koans/mp3

mkdir -p /tmp/bash_koans/txt

mkdir -p /tmp/bash_koans/html

if [ -z "$1" ]                           # Is parameter #1 zero length?
then

    echo1 'zero length, exit!'
    exit
fi




file_essay=~/tmp/ofer/essay.txt

file_sentance=/tmp/sentance.txt
#echo1 '' > $file_sentance




#echo1 "$file_essay"

SCRIPTPATH=`pwd -P`

#echo1 $SCRIPTPATH



#echo1 $SCRIPTPATH


#echo1 ${file_image_group} 
declare -A ln_arr3

ln_arr3["hi"]="Hindi"
ln_arr3["en"]="English"
ln_arr3["ar"]="Arabic"
ln_arr3["tl"]="Filipino"
ln_arr3["it"]="Italian"
ln_arr3["ru"]="Russian"


declare -A ln_arr2
ln_arr2["en"]="English"
ln_arr2["tl"]="Filipino"
ln_arr2["ar"]="Arabic"
ln_arr2["ru"]="Russian"
ln_arr2["la"]="Latin"
ln_arr2["el"]="Greek"
ln_arr2["fr"]="French"
ln_arr2["it"]="Italian"
ln_arr2["es"]="Spanish"
ln_arr2["pt"]="Portuguese"
#ln_arr2["ko"]="Korean"
ln_arr2["hi"]="Hindi"
ln_arr2["ja"]="Japanese"
ln_arr2["zh"]="Chinese"
#ln_arr2["iw"]="Hebrew"
#ln_arr2["yi"]="Yiddish"





declare -A ln_arr
ln_arr["ja"]="Japanese"
ln_arr["cs"]="Czech"
ln_arr["af"]="Afrikaans"
ln_arr["sq"]="Albanian"
ln_arr["ar"]="Arabic"
ln_arr["hy"]="Armenian"
ln_arr["az"]="Azerbaijani"
ln_arr["eu"]="Basque"
ln_arr["be"]="Belarusian"
ln_arr["bn"]="Bengali"
ln_arr["bg"]="Bulgarian"
ln_arr["ca"]="Catalan"
ln_arr["zh-CN"]="Chinese (Simplified)"
ln_arr["zh"]="Chinese"
ln_arr["hr"]="Croatian"
ln_arr["da"]="Danish"
ln_arr["nl"]="Dutch"
ln_arr["en"]="English"
ln_arr["eo"]="Esperanto"
ln_arr["et"]="Estonian"
ln_arr["fo"]="Faroese"
ln_arr["tl"]="Filipino"
ln_arr["fi"]="Finnish"
ln_arr["fr"]="French"
ln_arr["gl"]="Galician"
ln_arr["ka"]="Georgian"
ln_arr["de"]="German"
ln_arr["el"]="Greek"
ln_arr["gu"]="Gujarati"
ln_arr["ht"]="Haitian Creole"
ln_arr["iw"]="Hebrew"
ln_arr["hi"]="Hindi"
ln_arr["hu"]="Hungarian"
ln_arr["is"]="Icelandic"
ln_arr["id"]="Indonesian"
ln_arr["ga"]="Irish"
ln_arr["it"]="Italian"
ln_arr["kn"]="Kannada"
ln_arr["ko"]="Korean"
ln_arr["lo"]="Laothian"
ln_arr["la"]="Latin"
ln_arr["lv"]="Latvian"
ln_arr["lt"]="Lithuanian"
ln_arr["mk"]="Macedonian"
ln_arr["ms"]="Malay"
ln_arr["mt"]="Maltese"
ln_arr["no"]="Norwegian"
ln_arr["fa"]="Persian"
ln_arr["pl"]="Polish"
ln_arr["pt"]="Portuguese"
ln_arr["ro"]="Romanian"
ln_arr["ru"]="Russian"
ln_arr["sr"]="Serbian"
ln_arr["sk"]="Slovak"
ln_arr["sl"]="Slovenian"
ln_arr["es"]="Spanish"
ln_arr["sw"]="Swahili"
ln_arr["sv"]="Swedish"
ln_arr["ta"]="Tamil"
ln_arr["te"]="Telugu"
ln_arr["th"]="Thai"
ln_arr["tr"]="Turkish"
ln_arr["uk"]="Ukrainian"
ln_arr["ur"]="Urdu"
ln_arr["vi"]="Vietnamese"
ln_arr["cy"]="Welsh"
ln_arr["yi"]="Yiddish"

update_file(){
    if [ "$push_top" = false  ];then
        file=$2
        str=$(echo -n "$1")
        echo1 "update $file with: $str"
        echo "$str" >> $file
    else
        str=$(echo -n "$1")
        echo1 "update file with: $str"
        file=$2
        cat $file > /tmp/1.txt
        echo1 "$str"
        echo "      $str" > $file
        cat /tmp/1.txt >> $file
        #echo1 'updated file is:'
        #cat $file
    fi

}


translate_f(){
    #from english
    # if [ -z "$2" ]                           # Is parameter #1 zero length?
    # then
    #     echo1 "-Parameter #1 is zero length.-"  # Or no parameter passed.
    # else
    local lang=$1 #translate to..

    #local file_image_group=$(  echo1 group_${lang}.png )
    local input=$2 #translate src
    #debug: echo1 $input
    local lang_long=$3 

    local output=''
    local output_wsp=''
    local output_ws=''

    local show_one=''

    local input_wsp=$(echo "$input"|sed 's/ /+/g');
    local input_ws=$(echo "$input"|sed 's/ /_/g');


    local  mp3_file=/tmp/bash_koans/mp3/${input_ws}_${lang}.mp3
    #local  mp3_file=/tmp/bash_koans/mp3/${lang}.mp3
    local phonetics=''

    local str1=''
    local file_name=''

    if [[ $article != 'true' ]]
    then
        echo1 'its not an article!'
        file_name=$(  echo /tmp/bash_koans/txt/${input_ws}_${lang}.txt )

        #cat "$file_name" >> $file_sentance
    else
        echo1 'its an article!'

        echo1 "article file input: $file_essay"
        file_name=$(  echo /tmp/bash_koans/html/${lang}.html )
        rm $file_name
    fi




    files=$(ls  $file_name 2> /dev/null )

    if [[ ! "$files"  ]]
    then
        #echo1 'file not exist'
        #echo1  "need to translate.."

        if [[ $article != 'true' ]]
        then
            result=$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$input_wsp&sl=en&tl=$lang" ) 
            echo1 "$result"
            # show_one=`cat "$file_name"`
            cleaner=$(echo "$result" | sed 's/\[\[\[\"//') 
            echo $cleaner > /tmp/dirty.txt
            phonetics=$(echo "$cleaner" | cut -d \" -f 5)
            output=$(echo "$cleaner" | cut -d \" -f 1)

            output_wsp=$(echo "$output"|sed 's/ /+/g');
            output_ws=$(echo "$output"|sed 's/ /_/g');

            touch "$file_name"
            #echo1 -n "$lang :" >>   "$file_name"

            echo -n  "$output" >>   "$file_name"
            if [ "$phonetics"  != '' ]
            then
                
                if [ $lang != 'ru' ]
                then
                    
                    echo -n " _ $phonetics" >>   "$file_name"
                fi

            fi




            # echo1 -n  "$output" >>   $file_to_update
            #update_file "$phonetics" "$file_to_update"
            if [ "$push_top" = true ];then 

                update_file  "$output ::: $phonetics ::: $input "  "$file_to_update"
            else

                update_file  "$output ::: $phonetics"  "$file_to_update"
            fi


            #update_file  "$output _ $phonetics "  "$file_essay"

            #update_file  "$input"  "$file_to_update"
            #  file_to_update1=~/tmp/ofer/essay.txt
            #  update_file "$phonetics" "$file_to_update1"
            #  update_file  "$output"  "$file_to_update1"
        else
            echo1 'it is an article !'
            result=$(translate-bin -s $service -f en -t $lang $file_essay) 
            echo1 "$result"
            touch "$file_name"
            echo "$lang_long :" >>   "$file_name"
            #back to result !
            echo "$result" >>   "$file_name"

            #echo1 "$result" >>   "$file_to_update"


        fi

        if [ "$silent_fetch" = false ];then
            #echo1  "no silent !"

            echo1 'fetch sound'
            if [ $lang = 'tl' ]
            then

                #echo1 'lion is cool too also' | flite -o dog.wav | lame -b 128 dog.wav dog111.mp3 | play dog111.mp3
                #echo1 "$output" | flite -o /tmp/1.wav | lame -b 128 /tmp/1.wav $mp3_file | play $mp3_file 
                rm /tmp/1.wav
                #echo1 $output | flite $mp3_file #-o /tmp/1.wav | #| lame -b 128 /tmp/1.wav $mp3_file #&&  play $mp3_file #/tmp/1.wav
                echo1 $output
                echo -n "$output" | text2wave -o "$mp3_file" #/tmp/1.wav | lame /tmp/1.wav  $mp3_file 
                #/tmp/2.mp3 # | play /tmp/2.mp3
                #play $mp3_file

                #wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=en\&q=${output_wsp} > $mp3_file
            else
#echo "$output" | espeak -v "$lang"
                ( wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=${lang}\&q=${output_wsp} > $mp3_file \&\& play  $mp3_file \&)
            fi
        else
            echo1 'no fetch sound'

        fi

        echo "----" >> "$file_group"
        echo "$input" >> "$file_group"
        cat "$file_name" >> "$file_group"
        str7=`cat $file_name`
        echo "$str7" >> $file_sentance

        #update_file "$str7" "$file_to_update"

    else
        #echo1   'file exist'
        echo1   "$lang_long" "Cached Copy!" 


    fi
    if [[ $silent_msg = false ]]
    then

        let "r = $RANDOM % 4 "
        color="${color_arr1[$r]}"


         #   if [  $lang = 'ar' ] ||  [ $lang = 'hi'  ] ||  [ $lang = 'tl'  ]
            if [  $lang = 'en' ] || [ $lang = 'it' ] || [ $lang = 'ru' ] # || [ $lang = 'ar' ]
            then

#echo1 ''

        ( gxmessage -nofocus -buttons "was easy ?" -sticky -timeout 11 -title "$input_ws"  -file $file_name -geometry 600*900 -font "serif bold 18" -wrap -fg $color $ICONIC &)
            else

        ( gxmessage -nofocus -buttons "was easy ?" -sticky -timeout 11 -title "$input_ws"  -file $file_name -geometry 600*900 -font "serif bold 18" -wrap -fg $color $ICONIC &)
            fi



    fi
    
    if [ "$silent" = false ];then
        echo1 'PLAY !'
        echo1 "play $mp3_file" 
        #echo1 "$lang_long" | espeak -v en
        if [ "$silent_fetch" = true ]
        then
          #  ( play  $mp3_file &)
          echo1 'silent fetch'
        else



         #   if [  $lang = 'ar' ] ||  [ $lang = 'hi'  ] ||  [ $lang = 'tl'  ]
            if [  $lang = 'en' ] || [ $lang = 'it' ] || [ $lang = 'ru' ] # || [ $lang = 'ar' ]
            then
                play  $mp3_file 
            else



            play  $mp3_file 

            play  $mp3_file 
            play  $mp3_file 
            fi
 




        fi

    fi


    show_lang_group=$(cat $file_name | head -6)



    #echo1 "content: $show_lang_group file is: $file_name "


}

if [[ $many = -l || $many = --list ]]; then #list

    #cp $file_sentance /tmp/sentance.bak
    rm $file_sentance
    touch  $file_sentance
    param1="${!ln_arr3[@]}"

    echo1 "$param1"

    for i in $param1 ;do
        lang="$i"
        file_group=$(  echo /tmp/bash_koans/group_${lang}.txt )

        touch "$file_group"

        param2="${ln_arr3[$i]}"

        word="$word"
        lang_long="$param2"
        # echo1 "$lang_long"
        translate_f "$i" "$word" "$lang_long"

    done #| sort -k2

    #str=`/TORRENTS/SCRIPTS/EXEC/remove_endl.sh $file_sentance`
    #cat $file_sentance
    #echo1 $file_sentance 
else
    lang=$many
    file_group=$(  echo /tmp/bash_koans/group_${lang}.txt )

    touch "$file_group"

    i=$lang
    # echo1 "lang is: $i"
    param2="${ln_arr[$i]}"
    word="$word"
    lang_long="$param2"
    translate_f "$i" "$word" "$lang_long"
fi




#echo1 finitto | espeak -v it

group1=`cat "$file_group"`
group1_ws=$(echo "$group1"|sed 's/\n/_/g' | tail -10) 
#echo1  "group:  $group1_ws" "file: $file_group"

if [[ "$update_google" = 'true' ]]
then
    google calendar --debug add  -d 'today at 10pm' --src "$group1_ws"
    echo1 "google_u enable !" 
else
    echo1 ''
    #echo1 "google_u disable !" 
fi






#pwd

popd > /dev/null
exit 0
