#!/bin/bash
#-x

# about file:
# run series of tasks
# each task call to another function
# example:
# timer.sh series 'input_task,suspend'
# will execute 2 function: input_task() and then suspend()
#

pushd `dirname $0` > /dev/null
#add to .bashrc:
#export TIMERTXT_CFG_FILE=~/.bash_it/ofer1/cfg/timer.cfg

. $TIMERTXT_CFG_FILE
#. $TIMERTXT_CFG_FILE


#string ()
#{
#  eval  "$1='some other string'"
#} # ----------  end of function string  ----------
#
##string globalvar
#
##echo "'${globalvar}'"


if [ "$1" = '' ];then
    exit 1
fi
#export REPORT_FILE="$TIMER_DIR/report.txt"

#export TIMERTXT_CFG_FILE="./cfg/timer.cfg"
#echo2 "cfg is: $TIMERTXT_CFG_FILE"
#ls -l $TIMERTXT_CFG_FILE
#cat $TIMERTXT_CFG_FILE

declare -i my_score
my_score=0 #-1
#gxmessage   'every input str should contain atleast 1 word that used before !'
echo2 "timer.sh got: 1:$1 2:$2 3:$3"



#    translate_f "$i" "$word" "$lang_long"


game1(){
    local str=''
    reset
    white "WELLCOME TO THE GAME!"
    white "AUTO-COMPLETION "
    green "ESSAY "
    white "MEMORY "
    white "GAIN POINTS "
    white "MY QUOTE WORTH A TWEET!"
    #    
    #    echo 'which words you must know the tranlsation?'
    #    echo 'choose language:'
    #    echo 'list of must-know-words for today:'
    #    echo 'try to remember the translation and write your answer'
    #    echo 'your points are: X'
    #
    echo ''
    echo 'Pick a language:'
    read lang 

    echo 'Enter a string:'
    if [ "$lang" != '' ];then

        while [ "$str" != 'exit' ];do
            #echo2 'Enter a string:'
            read str 
            if [ "$str" = 'exit' ];then
                break
            else
                #echo2 'translation:'
                #$TIMER2_DIR/timer.sh 

                return_var=''
                translate_f return_var "$str" "$lang" 

                #echo $return_var
            fi

        done

    fi


}
printing1(){
    local input_ws="$1" 
    local file_name="$2"

    local line1=`cat $file_name | head -1`
    local line2=`cat $file_name | head -2 | tail -1`

        local line3=$(echo "$line2"|sed 's/ /:1,/g');

    if [ $GUI = true ]
    then

        let "r = $RANDOM % 4 "
        color="${color_arr1[$r]}"
        #echo2 "color: $color"
        
        ( gxmessage "$line1" -buttons "$line3" -sticky -timeout 11 -title "$input_ws"  -geometry 600*900 -font "serif bold 18" -wrap -fg $color $ICONIC &)
    else
      echo '' #  cat $file_name 
    fi

        cat $file_name 


        #echo "$input_ws"

}

play1(){

        #echo "play1() got: $1 | $2"
    if [ $PLAYING_ON = false ];then


        export PLAYING_ON=true


        local lang="$2"

        local lang_repeat=\$"$lang"R   # Name of variable (not value!).

        local  times=`eval "expr \"$lang_repeat\" "`
        local file="$1"

        #declare  -i  counter
        local counter=0
        while [  $counter -lt  $times ]; do
            if [ "$SILENCE" = false ];then

                play -V1 -q  "$1"
            fi

            (( counter++ ))
        done

        export PLAYING_ON=false
    else
        red 'playing is already on'
        Backtrace
    fi



}


translate_f(){

    local silent_fetch=$SILENT_FETCH
    local silent=$SILENT

    local lang="$3"
    echo2 "translate_f() got:  $1 | $2 | $3"

    local input="$2" #translate src
    local input_wsp=$(echo "$input"|sed 's/ /+/g');
    local input_ws=$(echo "$input"|sed 's/ /_/g');

    local  mp3_file=$dir_mp3/${input_ws}_${lang}.mp3
    local file_name=$(  echo $dir_txt/${input_ws}_${lang}.txt )



    local files1=$(ls  $file_name 2> /dev/null )
    local files2=$(ls  $mp3_file 2> /dev/null )
    if [ ! "$files1"  ] #|| [ ! "$files2" ]
    then

        echo2 "fetch txt"
        #echo1 'file not exist'
        #echo1  "need to translate.."


        result=$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$input_wsp&sl=en&tl=$lang" ) 
        cleaner=$(echo "$result" | sed 's/\[\[\[\"//') 
        phonetics=$(echo "$cleaner" | cut -d \" -f 5)
        output=$(echo "$cleaner" | cut -d \" -f 1)

        output_wsp=$(echo "$output"|sed 's/ /+/g');
        output_ws=$(echo "$output"|sed 's/ /_/g');


        touch "$file_name"
        echo "$output" >   "$file_name"

        if [  $lang = 'ru' ] || [ $lang = 'hi' ]
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

            #echo1  "no silent !"

            echo2 'fetch sound'
            if [ $lang = 'tl' ]
            then

                rm /tmp/1.wav
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
 
    printing1 "$input_ws" "$file_name"
    if [ "$silent" = false ];then
        echo1 'play1 !'
        echo1 "play1 $mp3_file" 
        if [ "$silent_fetch" = true ]
        then
            #  ( play1  $mp3_file &)
            echo2 'silent fetch'
        else
            play1  $mp3_file $lang 
        fi

    fi


    eval "$1=\"$str1\""  # Assign new value.

}


input_line(){
    #latest modifications: 
    #pass reference by supplying name of global variable.
    #





    local file="$1"
    local title="$2"
    #local last_input="$3"
    y=\$"$3"   # Name of variable (not value!).
    echo1 $y    # $Junk

    x=`eval "expr \"$y\" "`
    echo $3=$x
    echo1  "$3 " 

    say1 "$x"


    answer=$( gxmessage  -buttons "_ $x"  -entry -title "$title" -file  "$file" -ontop -timeout $TIMEOUT1 )

    eval "$3=\"$answer\""  # Assign new value.

    if [ "$answer" = exit ]
    then
        exiting
    fi


    if [ $TRANSLATE = true ]
    then

        say2 "$answer" -l $file true 

    fi

    cat $file > /tmp/1.txt 
    date1="$(date +%H:%M)"
    #echo "_____________________" > $file
    echo "$date1 - $answer" > $file
    cat /tmp/1.txt >> $file

}



check_in_file(){


    local group1="$1"
    local file=$2
    #local item=$1

    #local result=$(cat /tmp/test1 | grep -o "$item" | wc -l)
    local group2=$( cat "$file" )
    check_subgroup "$group1" "$group2"

    #return $?

}
check_subgroup() {
    local number=0
    local group1="$1" #"root boots"
    local group2="$2" #"root boot boots"
    local answer=0 


    for item in $(echo $group1)
    do 
        check_item "$item" "$group2" 
        answer=$?


        if [ $answer = 1 ]
        then
            let "my_score += 1"
        else
            let "my_score -= 1"
        fi



    done

    #return $number

}


check_item(){
    local result


    item=$1 #'root'
    group=$2 #"boots roots root"

    #count instances of item in group

    local count=$(echo "$group" | grep -o "$item"   | wc -w )


    result=$( test $count -eq 0  && echo 0 || echo 1 )
    return $result

}
#ffmpeg -an -f video4linux -s 320x240 -b 800k -r 15 -i /dev/v4l/video0 -vcodec mpeg4 myvideo.avi
rooting(){
    echo1 'how to root a close device to a789 ?'
    echo1 'http://www.tipidcp.com/viewtopic.php?tid=33617&page=1'
    xdg-open 'http://www.china1buye.com/lenovo-a789-mtk-6577-dual-core-cortex-a9-1-0ghz-android4-0-gps-dual-camera-5-0mp-4-inch-smartphone'

    echo1 'where r the roms and backup tools ?'
    xdg-open 'http://d-h.st/users/cybermaus/?fld_id=9986#files'


    echo1 '1. GENERAL RECOVERY'
    http://bm-smartphone-reviews.blogspot.nl/2012/02/complete-guide-to-clockworkmod-recovery.html

    echo1 'how to root different lenovo phone ?'
    echo1 'http://www.youtube.com/watch?v=Qo8xrxMisr8'

    echo1 'android: hebrew forum about flashing a rom of a789'
    echo1     'http://iandroid.co.il/forum/topic111628.html'
}



lang='it'
#'false'

declare -i reminder 
declare -i counter 
counter=0



#"$2s"

#declare -A arr1
#arr1["en"]="English"
configuration(){
    echo1 "silent? $silent  "
}


learn_web(){

    dir=/TORRENTS/AUDIO/ANGULAR
    (gedit "$dir/*.txt" &)
    #/home/dao01/desktop/shit/www.egghead.io.html)
    (vlc "$dir" &)
    #egghead.io - angularjs - built-in filters-d4nya-sfnzg.mp4")
    echo1 'cd /TORRENTS/RAILS/BACKBONE/ANGULAR/angular-phonecat/'
}
learn_security(){
    (vlc "$dir/security00.mp4")&
    #http://www.youtube.com/playlist?list=PLF360ED1082F6F2A5
    #http://www.wireshark.org/docs/
}
learn_book_splitter(){
    echo1     'http://docs.angularjs.org/guide/dev_guide.templates.databinding'
    echo1 'http://plnkr.co/edit/6UYL17'
    msg='what is the next task in book splitter ? '


    gxmessage  -buttons "_$last_task" "$msg"  -sticky -ontop

    msg='make it play sound simultaniously'
    gxmessage  -buttons "_$last_task" "$msg"  -sticky -ontop

}
learn_android(){
    xdg-open 'http://www.diygenius.com/how-to-learn-android-app-development-online/'
    xdg-open 'http://marakana.com/training/android/android_internals.html'
    xdg-open 'http://www.freewaregenius.com/twenty-five-free-online-tutorials-for-learning-android-programming/'
    xdg-open 'http://www.youtube.com/results?search_query=android&filters=playlist&lclk=playlist'
    xdg-open 'http://xmodulo.com/2013/05/how-to-install-and-run-android-x86-on-virtualbox.html'


    # //opensource
    echo1 https://play.google.com/store/search?q=%27open+source%27+game+port&c=apps
}
build_android(){
    echo1 'http://www.kickstarter.com/projects/435742530/udoo-android-linux-arduino-in-a-tiny-single-board?ref=search#faq_55732'
    echo1 'build a789 rom'
    xdg-open 'http://forum.xda-developers.com/showthread.php?t=1899245'

}

buy()
{
    echo1 'build a laptop'
    xdg-open 'http://www.kickstarter.com/projects/lividesign/casetop-every-phone-becomes-a-laptop'
    #go to zap  and search for replacement part + do it in ebay too
    echo1  ''
    echo1 'http://www.engadget.com/tag/MiniPc/'
}

time1(){

    date1="$(date +%H:%M)"
    ( gxmessage  -buttons "_$last_task" "time: $date1"  -sticky -ontop -font "serif bold 74" -timeout $TIMEOUT1 &)
    say1 "$date1"


}

suspend1(){


    take_photo

    say1 "$msg_suspend" 
    dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend
    answer=$( messageYN 'yes/no question' 'break through! | did sport? | update wall? | know next task?' )
    if [ "$answer" = 2 ];then
        echo '+1 point'
        echo -n '+' >> $sport_txt
    fi
}


suspend2(){

    say1 "$msg_others"
    sleep1 5 
    if [ "$1" = '' ] 
    then
        #say1 "$last_suspend"
        dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend
    else
        echo2 "suspend1() got: $1 $2"

        say1 "$last_suspend" 
        gxmessage -buttons "_$last_task" "sudpending: $date1, timeout is: $TIMEOUT1 "  $gxmessage 0 -timeout $TIMEOUT1 




        echo2 "#sleep2 for $SLEEP seconds"

        sleep1 $SLEEP 

        if [ "$answer" = 2 ];then

            dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend

        fi
        echo2 'got back from suspension'


        #done
    fi
    echo "update your points" | flite
    #answer=$( gxmessage  -buttons "ok" "next task is:"  $gxmessage 1 -entry )
    #echo2 "$answer" >> $rules_txt
    #0 -timeout $TIMEOUT1 


}
network(){
    echo1 'bash examples:'
    xdg-open 'http://www.thegeekstuff.com/2009/07/linux-ls-command-examples/'
    echo1 'show apps that use network right now'
    lsof -P -i -n | cut -f 1 -d " "| uniq | tail -n +2

    echo1 'which app use which port'
    lsof -Pan -i tcp -i udp

    echo1 'show hardware being recognized'
    lshw

    echo1 'kernel dependency graph'
    lsmod | perl -e 'print "digraph \"lsmod\" {";<>;while(<>){@_=split/\s+/; print "\"$_[0]\" -> \"$_\"\n" for split/,/,$_[3]}print "}"' | dot -Tpng | display -

    echo1 'Create a system overview dashboard on F12 key'
    bind '"\e[24~"':"\"ps -elF;df -h;free -mt;netstat -lnpt;who -a\C-m"""
}
sport(){

    lang=$1
    echo1 'do sport for 1 minute'$ 
    sleep2 $SLEEP

    if [ $silent1 = false ]
    then
        echo1 'learn lang'
        learn_lang $lang
        echo1 'learn lang1'
        #    learn_lang1 $lang
    fi



    sleep2 $SLEEP
    #take_photo


    sleep2 $SLEEP




    echo1 'come back - everything is possible now' 





}
send_essay(){


    echo2 "send essay got: first: $1 | second: $2"
    local lang="$1"


    kuka_file=/home/dao01/tmp/timer2/essays/essayru.txt
    kuka_subject="ofer to kuka: my essay"



    pini_file=/home/dao01/tmp/timer2/essays/essayhi.txt
    pini_subject="ofer to pini: my essay"


    alice_file=/home/dao01/tmp/timer2/essays/essaytl.txt
    alice_subject="ofer to alice: my essay"


    kuka_send="mpack -s '$kuka_subject' $kuka_file '$MAIL2 ,  $MAIL1'"
    pini_send="mpack -s '$pini_subject' $pini_file '$pini_email ,  $MAIL1'"
    alice_send="mpack -s '$alice_subject' $alice_file '$alice_email ,  $MAIL1'"

    alice_echo='echo $alice_send'
    kuka_echo='echo $kuka_send'
    pini_echo='echo $pini_send'

    if [ "$lang" = ru ]
    then
        echo2 "$kuka_send"
    elif [ "$lang" = hi ]
    then
        echo2 "$pini_send"
    elif [ "$lang" = tl ]
    then
        echo2 "$alice_send"
    else
        echo 'no recipiant'
    fi





}

write_essay(){
    echo2 "write essay got: first: $1 | second: $2"
    if [ "$1" != '' ]
    then

        lang="$1"
    fi


    dereference msg_m0 

}

learn_lang(){

    #say1 "$last_essay" 

    lang=$1
    declare -i num
    lesson=$2
    num=$lesson
    num=num+2

    (xdg-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}0${num}.HTM" &)
    num=num-2



    (write_essay &)



    echo1 'playing..'

    play "/TORRENTS/AUDIO/LANGS/${lang}/EN${lang}0${num}.mp3"




}

learn_lang1(){
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

translate1(){


    local article=false
    local silent=true
    local silent_msg=true
    local silent_fetch=true



    local str="$1"
    local lang="$2"

    local file=$3

    local push_top=$4


    echo2 "translate1 got: str:$str , lang:$lang file:$3 -- push_top:$4 ---  article: $article , silent: $silent, silent_msg: $silent_msg , silent_fetch: $silent_fetch"


    #local file5=~/tmp/timer2/essay${lang}.txt
    #touch $file5

    if [ "$str" != '' ]
    then




        langs=$(lower $lang)

        $translate_sh "$str" "$lang" $article $silent $silent_msg $file $silent_fetch $push_top

    else

        echo1 "no str to translate"
    fi



}
translate_file()
{
    # /TORRENTS/SCRIPTS/EXEC/remind.sh 4 
    echo1 "$1"
    if [[ "$1" ]]
    then
        echo1 'translate msg'


    else
        echo1 'take 1 line of imagine.txt'
        #~/tmp/timer2/thanks.txt
        str4=$(cat $file_thanks | head -1)
        echo1 $str4
        str5=$(echo "$str4"  | tr -d '\012\015')
        langs='-l'



    fi


}

breath(){

    /TORRENTS/SCRIPTS/EXEC/remind.sh  
}

quote(){

    /TORRENTS/SCRIPTS/EXEC/remind.sh 2 
}

motivation_end(){




    say1 "$msg_m6" false 
    say1 "$msg_m7" false 

    say1 "$msg_m8" false 




    # /TORRENTS/SCRIPTS/EXEC/remind.sh 5 
}

take_photo(){
    say1 "$last_camera_before" 
    pic_file=$(echo ~/pictures/webcam-$(date +%m_%d_%Y_%H_%M).jpeg)


    ffmpeg -y -r 1 -t 3 -f video4linux2 -vframes 1 -s sxga -i /dev/video0 $pic_file

    say1 "$last_camera_after" 
    (xloadimage $pic_file &)
}

say1(){

    echo1 "say1() \n ------------ \ngot :    $1 ||  $2 ||  $3 ||  $4"
    Backtrace
    #sleep1 10
    #gxmessage  -entry -timeout 10 -title "say1() is running" 'onEntering'
    #-timeout $TIMEOUT1 $gxmessage 0
    local msg="$1"

    if  [ "$SILENCE" = false] && [ "$PLAYING_ON" = false ] 
    then

        #gxmessage  -entry -timeout 10 -title "say1() is running" 'talking' 
        echo "$msg" | flite -voice rms 
        echo "$msg" | flite -voice slt
        $translate_sh "$msg" "it"
        #$translate_sh "$msg" "it"

        $translate_sh "$msg" "ru"
        #$translate_sh "$msg" "ru"

        #$translate_sh "$msg" "ar"
        $translate_sh "$msg" "ar"


        $translate_sh "$msg" "hi"
        #$translate_sh "$msg" "hi"

        $translate_sh "$msg" "tl"
        #$translate_sh "$msg" "tl"
        sleep1 10
        # $translate_sh "$msg" "ru" $article $silent $silent_msg $file $silent_fetch $push_top
    else

        red 'other procces is already playing'
    fi


}


say2(){
    Backtrace
    echo1 "say2() got :  msg:  $1 || lang: $2 || file: $3 || push_top: $4"
    echo1 "say1 push_top = true" 
    if [ "$PLAYING_ON" = false ];then



        local msg="$1"
        local lang=$2
        local file=$3
        local push_top=$4
        if [ "$msg" != '' ]
        then
            if [ "$lang" != '' ];then
                translate1 "$msg" "$lang" $file $push_top 
            fi
        fi
    else
        red 'already playing'

    fi

}
update_file(){
    local file=$1
    local msg=$2

    local last=$3




    answer=$( gxmessage  -buttons "_$last_task"  -entry -title "$msg" -file  "$file" -ontop -sticky )

    cat $file > /tmp/1.txt 


    echo "$answer" > $file

    cat /tmp/1.txt >> $file


}

twitter(){

    msg='write twitter:'

    answer=$( gxmessage  -buttons "_$last_task"  -entry -title "$msg" -file  "$file2" -ontop -sticky )
    if [[ "$answer" != '' ]]
    then

        cat $file2 > /tmp/1.txt 

        date1="$(date +%H:%M)"
        echo "$date1 -  $answer" > $file2

        cat /tmp/1.txt >> $file2


        ttytter  -status="$answer"

    fi
    #http://www.floodgap.com/software/ttytter/copts.html

    #cp /TORRENTS/SCRIPTS/END/DEPLOY/tasks/html/all.html /tmp/bash_koans/html/
    #xdg-open /tmp/bash_koans/html/all.html

}

update_wallpaper(){
    echo 'update desktop' | flite  
    #/TORRENTS/SCRIPTS/MIDDLE/ENGLISH/script.sh
    ./wallpaper.sh
}


test1(){
    echo1 $TIMER_DIR
    exit
    say1 "I love you" 

    sleep2 5s

    echo1 'exiting'
    exit 0

    str=$1
    if [ "$str" = true ]
    then
        echo1 'result: true'
    else
        echo1 'result: false'

    fi 

}
learn_bash(){
    say1 "$last_bash" 
    ( xdg-open 'http://wiki.bash-hackers.org/doku.php' &)
}

motivation_start(){

    # (update_file "$file5" 'ESSAY:' $last_essay &)
    say1 "$msg_m1" false 

    #    say1 "$msg_m2" false 

    #   say1 "$msg_m3" false 
    #   say1 "$msg_m4" false 



    #say1 "$msg_m2"
    #say1 "$msg_m3"
    #say1 "$msg_m4"
}

update_score() {
    local group1="$1"
    local file="$2" 
    check_in_file "$group1" "$file"

    # return $?
}
dereference(){
    echo2 "lang: $lang | dir essay: $dir_essay | file5:  $file5"
    local file5="$dir_essay/essay${lang}.txt"
    touch $file5

    msg_m0="start"
    #local score=0
    while [ "$msg_m0" != '' ];do

        y=\$"$1"   # Name of variable (not value!).
        #echo1 $y    # $Junk

        x=`eval "expr \"$y\" "`
        #echo2 $1=$x


        #  say1 "$x"
        #echo1 $str=$x
        # eval "$1=\"Some Different Text \""  # Assign new value.
        echo2 "$file5"


        #local label="_$last_task"
        local label="$my_score"


        answer=$( gxmessage -entry -buttons "$label" -center  -title "$x" -file "$file5" $gxmessage 0 -timeout 20 )

        eval "$1=\"$answer\""  # Assign new value.




        if [ "$answer" != '' ]
        then
            local plus=0
            echo1 'change value of $1'

            echo1 'before update score'
            update_score "$answer" $file5
            echo1 'after update score'
            say2 "$answer" $lang $file5 true




            #sleep2 1s
        fi



    done



}
update_env1(){
    echo1 'update env'

    lesson=$LESSON
    sec="${SLEEP}s"
    translate=$TRANSLATE
    silent1=$SILENCE
    timeout1=$TIMEOUT1



}

delete_files(){

    dir=~/tmp/timer2/daily
    dir1=~/tmp/timer2/essays

    for I in $(ls -1 --sort=time $dir/*.txt )
    do 


        #answer=$( gxmessage  -buttons "delete"  -entry -title "delete file:: $I" -file "$I" -ontop )
        blue 'press ESC to ignore '

        answer=$( messageYN "Delete file?" "$I" )
        #echo "answer is: $answer" 
        if [ "$answer" = 2 ];then

            echo '' > "$I"
            red 'clean file'
        else

            green 'ignore file'
        fi
    done
    for I in $(ls -1 --sort=time $dir1/*.txt )
    do 


        #answer=$( gxmessage  -buttons "delete"  -entry -title "delete file:: $I" -file "$I" -ontop )

        answer=$( messageYN "delete:" "$I")
        if [ "$answer" = 2 ];then

            echo '' > "$I"
            red 'clean file'
        else

            green 'ignore file'
        fi
    done
}

loop_learn1(){
    echo 'learn1'
    # $PWD/menu.sh
    green 'learn X words aday: use glossary.txt'

    cat "$dir_essay/essayIT.txt"
    cat "$dir_essay/essayRU.txt"
    cat "$dir_essay/essayHI.txt"
    cat "$dir_essay/essayAR.txt"
    cat "$dir_essay/essayTL.txt"

    white "choose a language: IT TL RU HI AR "  
    read lang 

    if [ "$lang" != '' ]
    then

        gedit $glossary_txt & 
        #$timer_sh 
        learn_lang $lang $LESSON
        #write_essay $answer
    fi
}

loop_play1(){
    echo 'play1'
    green 'run series of tasks in circle'
    if [ -t 0 ]; then stty -echo -icanon time 0 min 0; fi

    count=0
    keypress=''
    while [ "x$keypress" = "x" ]; do

        . $TIMERTXT_CFG_FILE

        let count+=1
        echo -ne $count'\r'
        read keypress

        ##############################################################
        #$TIMER2_DIR/timer.sh 
        series1 "$series1" 
        ##############################################################
        sleep1 10
    done

    if [ -t 0 ]; then stty sane; fi

    echo "You pressed '$keypress' after $count loop iterations"
    echo "Thanks for using this script."
    exit 0
}
loop_play2(){
    #sleep1 60
    echo 'play1'
    green 'run series of tasks in circle'
    if [ -t 0 ]; then stty -echo -icanon time 0 min 0; fi

    count=0
    keypress=''
    while [ "x$keypress" = "x" ]; do

        . $TIMERTXT_CFG_FILE

        let count+=1
        echo -ne $count'\r'
        read keypress

        ##############################################################
        #$TIMER2_DIR/timer.sh series 
        one_task1 
        ##############################################################
        sleep1 10
    done

    if [ -t 0 ]; then stty sane; fi

    echo "You pressed '$keypress' after $count loop iterations"
    echo "Thanks for using this script."
    exit 0
}

remind1(){

    #reset
    #echo "$str2"
    white "does the timer run with suspension ?"
    green "do you have schedules ?"
    white "did you write on the whiteboard ?"
    green "runner.sh - play motivations"
    red "klara - mother reminder"
    log1

}



#yellow "choose:\nEdit .txt\nPlay timer tasks\nUpdate .sh\nContinue to next menu\nQuit"




present1(){
    green 'post to blog ?'
    read answer
    if [  "$answer" = y ]
    then
        echo '~/.bash_it/blog/brownman.github.com'
        echo 'Jakyll serve'
        echo 'rake post title="day X: goal X"'
    fi


    green 'record screencast?'
    read answer
    if [  "$answer" = y ]
    then
        title=$( gxmessage "please title the screencast:" -entry )
        asciiio -t "$title"

    fi
    green 'add presentation to the README..?'
    read answer
    if [  "$answer" = y ]
    then
        echo "$?"
        gedit $PWD/README.md
    fi
    green 'publish to github ?'
    read answer
    if [  "$answer" = y ]
    then
        #cd..
        git add .
        line=$( gxmessage -buttons "I did add a presentation!" "write description for the commit" -entry -timeout 20 -title "Github update: ")
        if [ "$line" != '' ]
        then
            git commit -am "$line"
            git push origin develop
        fi
        #cd -
    fi
}



series1(){

    . $TIMERTXT_CFG_FILE
    local series="$1"
    local yno=""
    IFS=', ' read -a array <<< "$series"

    #echo "${array[0]}"
    #echo $str
    for index in "${!array[@]}"
    do
        green "current task: $index" 

        #$yno=`eval ${array[index]}`
        yno=`echo ${array[index]}`


        echo "$series" | grep $yno

        case $yno in
            "input_task")
                title="task:"
                file=$task_txt
                input_line $file "$title" last_task

                ;;
        "remind_me")
            say1 $msg_remind_me 
                ;;
            "time")
                time1
                ;;
            "motivation_start")
                motivation_start
                ;;
            "sleep")
                sleep1 $SLEEP
                ;;
            "mindmap")
                answer=$( messageYN "y/n question" "open mind map link ?" )
                if [ "$answer" = 2 ];then

                    xdg-open $mm_link &
                fi
                ;;
            "show_done")
                gxmessage  -title 'how to say..' -file $done_txt -timeout 30 
                ;;
            "show_todo")
                gxmessage  -title 'how to say..' -file $todo_txt -timeout 30 
                ;;
            "glossary")
                ( gxmessage  -title 'how to say..' -file $glossary_txt -timeout 30 &)
                write_essay "$LANG_ESSAY"
                ;;
            "suspend")
                suspend1
                ;;
            "rules")
                echo2 'update rules'
                messageANS "update rules" "$rules_txt" 
                ;;
            "one_task")
                one_task1
                ;;
            "schedule")
                xdg-open 'https://www.google.com/calendar/render?tab=mc'
                ;;

            "edit")
                ( xterm -e "$TIMER2_DIR/edit.sh" &)
                ;; 

            *) red "Invalid task:"
               yellow "$yno"
                ;;
        esac     

    done
    exit

    #answer=$( gxmessage  "$last_task" -center  -title "title"  "$gxmessage 1"  )


}

many1(){

    echo1 'PLAY AGAIN    '
    let "r = $RANDOM % 4 + 1"
    counter=$r

    #while :; do

    ( edit.sh &)
    echo1  "reload config file: $TIMERTXT_CFG_FILE"
    #### refresh vars ####
    . $TIMERTXT_CFG_FILE
    update_env 

    #######################
    echo1 "lesson is: $LESSON"

    echo1 "suspend is: $SUSPEND"
    echo1 "silence is: $silent1"
    sleep2 10s
    motivation_start 

    title="next task:"
    file=$file_task
    input_line $file "$title" last_task

    time1
    echo1 "run all tasks: one after another"
    let "reminder = $counter % 4"
    echo1 "the reminder is: $reminder"
    lang="${arr1[$reminder]}"

    #  sport $lang 


    counter+=1

    sleep2 $SLEEP


    if [ $INPUT_THANKS = true ]
    then

        title="thanks:"
        file=$file_thanks
        input_line $file "$title" last_thanks
    fi



    sleep2 $SLEEP

    sleep2 $SLEEP 
    #update_wallpaper
    #   (xdg-open 'https://www.google.com/calendar/render?tab=mc' &)
    motivation_end

    echo1 'suspend..'
    sleep2 10s 
    if [ "$SUSPEND" = true ];then

        suspend1
    fi

    (xloadimage $pic_file &)
    #done

    one_task1


}
motivation(){
    cat -n $motivations_txt
    echo "add motivation:"
    #everything is funny actualy"
    read answer

    if [ "$answer" != '' ];then
        echo "$answer" >> $motivations_txt 
    fi
    #cat -n $motivations_txt


}
one_task1(){

    if [ $PLAYING_ON = false ];then





        export PLAYING_ON=true
        file=$now_txt
        #while :; do






        first=`cat $file | head -1`

        str=$(gxmessage  -timeout $TIMEOUT1 -title '1 task:' -entry -file $file )
        if [ "$str" !=  ''  ] 
        then
            if [ "$str" = 'exit' ]
            then
                exit 1
            fi

            cat $file > /tmp/2.txt 
            echo "$str" > $file
            cat /tmp/2.txt >> $file
            #else
        fi



        first=`cat $file | head -1`
        $translate_sh "$first" 

        ########memory test

        file=$memory_txt

        str=$(gxmessage  -timeout $SLEEP -title 'memory?' -entry -file $file )
        if [ "$str" !=  ''  ] 
        then
            if [ "$str" = 'exit' ]
            then
                exit
            fi

            cat $file > /tmp/2.txt 
            echo "$str" > $file
            cat /tmp/2.txt >> $file
            #else
        fi

        #done



    else
        red "other proccess already playing "

    fi

    export PLAYING_ON=false
}

if [ $1 = "testing" ]
then
    last_task="rabbiit2"

    cat $file_task | head -3 


    cat $file_task | head -3 
    exiting
    #first=$(cat $todo_txt | head -1)
    first=`cat $todo_txt | head -1`
    echo1 $first
    #gxmessage  "$first"
    exiting
    gxmessage  'testing'

    #  say1 "hello world"


elif [ $1 = delete ];then
    echo1 'delete'

    delete_files 
elif [ $1 = translate ];then
    echo2 'translate'

    return_var=''


    translate_f return_var "$2" "$3"  



    #echo $return_var

elif [ $1 = meditate ];then
    echo1 'meditate'

    $TIMER2_DIR/meditate.sh 
elif [ $1 = watchr ];then
    echo1 'watchr'

    watchr $TIMER2_DIR/koans-linux.watchr 

elif [ $1 = fetch ];then
    echo1 'fetching'

    $TIMER2_DIR/fetch.sh 
elif [ $1 = mail ]
then
    $TIMER2_DIR/mail.sh

elif [ $1 = learn_lang ]
then
    echo2 "learn a language $1 | $2"
    lang1=$2
    lesson1=$3
    learn_lang $lang1 $lesson1


elif [ $1 = write_essay ]
then
    lang1=$2
    write_essay $lang1

elif [ $1 = send_essay ]
then
    lang1=$2
    send_essay $lang1

elif [ $1 = suspend ]
then
    suspend1
elif [ $1 = play1 ]
then
    loop_play1
elif [ $1 = play2 ]
then
    loop_play2

elif [ $1 = game1 ]
then
    loop_game1




elif [ $1 = english ]
then
    $TIMER2_DIR/english.sh
elif [ $1 = one_task ]
then
    one_task1
elif [ $1 = game ]
then
    echo 'let the game start'

    game1

elif [ $1 = remind ]
then
    echo 'remind me'

    remind1
elif [ $1 = present1 ]
then
    echo 'remind me'

    present1





elif [ $1 = series ];then # ------------------ all
    echo "series1() got: $2" 
    if [ "$2" = '' ];then

    series1 "$series1"
    else

    series1 "$2"
    fi

fi

#if [[ $1 = learn_web ]];then
#    learn_web
#fi

#pwd

popd > /dev/null
exit
#learn_book_splitter
#twitter
#youtube 
#learn_web
#learn_security

#kill
#http://www.linuxcommand.org/lts0080.php#listing_your_processes

#scratch linux
#http://www.linuxfromscratch.org/blfs/view/development/chapter07/network.html



