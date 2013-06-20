#!/bin/bash 
#-x

pushd `dirname $0` > /dev/null
if [ "$1" = '' ];then
    exit 1
fi
#export REPORT_FILE="$TIMER_DIR/report.txt"

export TIMERTXT_CFG_FILE="./cfg/timer.cfg"
echo "cfg is: $TIMERTXT_CFG_FILE"
ls -l $TIMERTXT_CFG_FILE
cat $TIMERTXT_CFG_FILE
. $TIMERTXT_CFG_FILE
declare -i my_score
my_score=0 #-1
gxmessage  'every input str should contain atleast 1 word that used before !'
echo "timer.sh got: 1:$1 2:$2 3:$3"
lower() { echo ${@,,}; }



input_line(){
#latest modifications: 
#pass reference by supplying name of global variable.
#





local file="$1"
local title="$2"
#local last_input="$3"
  y=\$"$3"   # Name of variable (not value!).
        echo $y    # $Junk

        x=`eval "expr \"$y\" "`
        echo $3=$x
       echo  "$3 " 

    say1 "$x"

   
    answer=$( gxmessage -buttons "_ $x"  -entry -title "$title" -file  "$file" -ontop -timeout $TIMEOUT1 )
    
     eval "$3=\"$answer\""  # Assign new value.
     
    if [ "$answer" = exit ]
    then
        echo 'exiting'
        exit 1
    fi


    if [ $TRANSLATE = true ]
    then

        say2 "$answer" -l $file true 

    fi

    cat $file > /tmp/1.txt 
    date1="$(date +%H:%M)"
    echo "_____________________" > $file
    echo "$date1 - $answer" >> $file
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
    echo 'how to root a close device to a789 ?'
    echo 'http://www.tipidcp.com/viewtopic.php?tid=33617&page=1'
    xdg-open 'http://www.china1buye.com/lenovo-a789-mtk-6577-dual-core-cortex-a9-1-0ghz-android4-0-gps-dual-camera-5-0mp-4-inch-smartphone'

    echo 'where r the roms and backup tools ?'
    xdg-open 'http://d-h.st/users/cybermaus/?fld_id=9986#files'


    echo '1. GENERAL RECOVERY'
    http://bm-smartphone-reviews.blogspot.nl/2012/02/complete-guide-to-clockworkmod-recovery.html

    echo 'how to root different lenovo phone ?'
    echo 'http://www.youtube.com/watch?v=Qo8xrxMisr8'

    echo 'android: hebrew forum about flashing a rom of a789'
    echo     'http://iandroid.co.il/forum/topic111628.html'
}


timer2_sh="$TIMER2_DIR/translate.sh"
#timer2_sh=/TORRENTS/SCRIPTS/EXEC/bash_koans/timer2.sh
msg_m0='I am writing short essay in many languages'
msg_m1='sign one circle on the wall' 
msg_m3='please update list' 
msg_m2='excellent' 
msg_m4='good'

msg_m6='write the impossible - the hardest thing for you' 

msg_m7='update your notebook please positively' 
msg_m8='you know what is right and what to do now' 

arr1=( IT AR HI RU )
lang='it'
#'false'

declare -i reminder 
declare -i counter 
counter=0

dir_essay=~/tmp/timer2/essays
file_task=~/tmp/timer2/daily/now.txt
file_thanks=~/tmp/timer2/daily/thanks.txt
#file_twitter=~/tmp/timer2/twitter.txt

last_task="you are the man"
#how easier can it realy be ?"
last_thanks="you can do it - it is so easy"
last_essay="essay step"
#timer2 - one step for man - one step for"
last_suspend="well - I am tired - i am going to sleep1 now - thanks for the fish" 

last_bash="linux programming start here"
#well - I am tired - i am going to sleep1 now - thanks for the fish" 


last_camera_before="" #say cheese little mouse" 
last_camera_after="" #this is much better" 

#"$2s"

#declare -A arr1
#arr1["en"]="English"
configuration(){
    echo "silent? $silent  "
}

sleep1()
{
    local sec=$1
    echo "sleeping for $sec"
    sleep $sec
}
echo "#sleep1 period is: $sec"
learn_web(){

    dir=/TORRENTS/AUDIO/ANGULAR
    (gedit "$dir/*.txt" &)
    #/home/dao01/desktop/shit/www.egghead.io.html)
    (vlc "$dir" &)
    #egghead.io - angularjs - built-in filters-d4nya-sfnzg.mp4")
    echo 'cd /TORRENTS/RAILS/BACKBONE/ANGULAR/angular-phonecat/'
}
learn_security(){
    (vlc "$dir/security00.mp4")&
    #http://www.youtube.com/playlist?list=PLF360ED1082F6F2A5
    #http://www.wireshark.org/docs/
}
learn_book_splitter(){
    echo     'http://docs.angularjs.org/guide/dev_guide.templates.databinding'
    echo 'http://plnkr.co/edit/6UYL17'
    msg='what is the next task in book splitter ? '


    gxmessage -buttons "_$last_task" "$msg"  -sticky -ontop

    msg='make it play sound simultaniously'
    gxmessage -buttons "_$last_task" "$msg"  -sticky -ontop

}
learn_android(){
    xdg-open 'http://www.diygenius.com/how-to-learn-android-app-development-online/'
    xdg-open 'http://marakana.com/training/android/android_internals.html'
    xdg-open 'http://www.freewaregenius.com/twenty-five-free-online-tutorials-for-learning-android-programming/'
    xdg-open 'http://www.youtube.com/results?search_query=android&filters=playlist&lclk=playlist'
    xdg-open 'http://xmodulo.com/2013/05/how-to-install-and-run-android-x86-on-virtualbox.html'


    # //opensource
    echo https://play.google.com/store/search?q=%27open+source%27+game+port&c=apps
}
build_android(){
    echo 'http://www.kickstarter.com/projects/435742530/udoo-android-linux-arduino-in-a-tiny-single-board?ref=search#faq_55732'
    echo 'build a789 rom'
    xdg-open 'http://forum.xda-developers.com/showthread.php?t=1899245'

}

buy()
{
    echo 'build a laptop'
    xdg-open 'http://www.kickstarter.com/projects/lividesign/casetop-every-phone-becomes-a-laptop'
    #go to zap  and search for replacement part + do it in ebay too
    echo  ''
    echo 'http://www.engadget.com/tag/MiniPc/'
}

time1(){
  
    date1="$(date +%H:%M)"
    (gxmessage -buttons "_$last_task" "time: $date1"  -sticky -ontop    -font "serif bold 74" &)
    say1 "$date1"
  

}


suspend1(){


    say1 "$last_suspend" 
    #while :; do
    gxmessage -buttons "_$last_task" "sudpending: $date1, timeout is: $TIMEOUT1 "  -sticky -ontop -timeout $TIMEOUT1



    echo "#sleep1 for $sec seconds"

    #sleep1 $sec 

    dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend
    echo 'got back from suspension'
    #done

}
network(){
    echo 'bash examples:'
    xdg-open 'http://www.thegeekstuff.com/2009/07/linux-ls-command-examples/'
    echo 'show apps that use network right now'
    lsof -P -i -n | cut -f 1 -d " "| uniq | tail -n +2

    echo 'which app use which port'
    lsof -Pan -i tcp -i udp

    echo 'show hardware being recognized'
    lshw

    echo 'kernel dependency graph'
    lsmod | perl -e 'print "digraph \"lsmod\" {";<>;while(<>){@_=split/\s+/; print "\"$_[0]\" -> \"$_\"\n" for split/,/,$_[3]}print "}"' | dot -Tpng | display -

    echo 'Create a system overview dashboard on F12 key'
    bind '"\e[24~"':"\"ps -elF;df -h;free -mt;netstat -lnpt;who -a\C-m"""
}
sport(){

    lang=$1
    echo 'do sport for 1 minute'$ 
    sleep1 $sec

    if [ $silent1 = false ]
    then
        echo 'learn lang'
        learn_lang $lang
        echo 'learn lang1'
        learn_lang1 $lang
    fi



    sleep1 $sec
    take_photo


    sleep1 $sec




    echo 'come back - everything is possible now' 





}



learn_lang(){

    say1 "$last_essay" 

    lang=$1
    declare -i num
    num=$lesson
    num=num+2

    (xdg-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}0${num}.HTM" &)
    num=num-2


    (dereference msg_m0 &)



    echo 'playing..'
    if [ $silent1 = false ];then

        play "/TORRENTS/AUDIO/LANGS/${lang}/EN${lang}0${num}.mp3"
    fi




}

learn_lang1(){
    lang1=$(lower $lang)
    echo $lang1
    #ls -1 --sort=time /tmp/bash_koans/txt/*.txt | grep -E "($lang1.txt|it.txt)"


    #exit

    for I in $(ls -1 --sort=time /tmp/bash_koans/txt/*.txt | grep -E "($lang1.txt|it.txt)")
    do 
        str1=$(echo $I | sed 's/txt/mp3/g' ) #| sed 's/word_//g')


        files=$(ls  $str1 2> /dev/null )

        if [[  "$files"  ]]
        then
            (say1 "$str1" &)
            gxmessage -buttons "_$last_task" -nearmouse -wrap -title "title"  -file $I -font "serif bold 34" -sticky
            echo "txt file: $I"


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

    echo "translate1 got: str:$str , lang:$lang file:$3 -- push_top:$4 ---  article: $article , silent: $silent, silent_msg: $silent_msg , silent_fetch: $silent_fetch"

    #local file5=~/tmp/timer2/essay${lang}.txt
    #touch $file5

    if [ "$str" != '' ]
    then




        langs=$(lower $lang)

$timer2_sh "$str" "$lang" $article $silent $silent_msg $file $silent_fetch $push_top

    else

        echo "no str to translate"
    fi



}
translate_file()
{
    # /TORRENTS/SCRIPTS/EXEC/remind.sh 4 
    echo "$1"
    if [[ "$1" ]]
    then
        echo 'translate msg'


    else
        echo 'take 1 line of imagine.txt'
        #~/tmp/timer2/thanks.txt
        str4=$(cat $file_thanks | head -1)
        echo $str4
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
    local msg="$1"
    echo "say1() \n ------------ \ngot :    $1 ||  $2 ||  $3 ||  $4"
    if [ "$SILENCE" = false ]
    then
        echo "$msg" | flite -voice rms 
        sleep1 2s
        echo "$msg" | flite -voice slt
    fi


}


say2(){
    echo "say2() got :  msg:  $1 || lang: $2 || file: $3 || push_top: $4"
    echo "say1 push_top = true" 

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

}
update_file(){
    local file=$1
    local msg=$2

    local last=$3




    answer=$( gxmessage -buttons "_$last_task"  -entry -title "$msg" -file  "$file" -ontop -sticky )

    cat $file > /tmp/1.txt 


    echo "$answer" > $file

    cat /tmp/1.txt >> $file


}

twitter(){

    msg='write twitter:'

    answer=$( gxmessage -buttons "_$last_task"  -entry -title "$msg" -file  "$file2" -ontop -sticky )
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
    /TORRENTS/SCRIPTS/MIDDLE/ENGLISH/script.sh
}


test1(){
    echo $TIMER_DIR
    exit
    say1 "I love you" 

    sleep1 5s

    echo 'exiting'
    exit 0

    str=$1
    if [ "$str" = true ]
    then
        echo 'result: true'
    else
        echo 'result: false'

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
exiting()
{
    echo 'exiting'
    exit
}
update_score() {
    local group1="$1"
    local file="$2" 
    check_in_file "$group1" "$file"

    # return $?
}
dereference(){
    echo 'dereference'
    local file5="$dir_essay/essay${lang}.txt"
    touch $file5

    msg_m0="start"
    #local score=0
    while [ "$msg_m0" != '' ];do

        y=\$"$1"   # Name of variable (not value!).
        echo $y    # $Junk

        x=`eval "expr \"$y\" "`
        echo $1=$x


        say1 "$x"
        #echo $str=$x
        # eval "$1=\"Some Different Text \""  # Assign new value.
        echo "$file5"


        #local label="_$last_task"
        local label="$my_score"


        answer=$( gxmessage -buttons "$label" -center  -title "$x" -file "$file5" "$GXMESSAGE1"  )

        eval "$1=\"$answer\""  # Assign new value.




        if [ "$answer" != '' ]
        then
            local plus=0
            echo 'change value of $1'
          
            echo 'before update score'
            update_score "$answer" $file5
            echo 'after update score'
                   say2 "$answer" $lang $file5 true




            #sleep1 1s
        fi



    done



}
update_env(){
    echo 'update env'

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


        answer=$( gxmessage -buttons "delete"  -entry -title "delete file:: $I" -file "$I" -ontop )
        if [ "$answer" != 'no' ];then

            echo '' > "$I"
            echo 'clean file'
        fi
    done
    for I in $(ls -1 --sort=time $dir1/*.txt )
    do 


        answer=$( gxmessage -buttons "delete"  -entry -title "delete file:: $I" -file "$I" -ontop )
        if [ "$answer" != 'no' ];then

            echo '' > "$I"
            echo 'clean file'
        fi
    done
}



if [ $1 = "testing" ]
then
last_task="rabbiit2"

    cat $file_task | head -3 

    sleep1 5s

    cat $file_task | head -3 
    sleep1 5s
    exiting
    #first=$(cat $TODO_FILE | head -1)
    first=`cat $TODO_FILE | head -1`
    echo $first
    #gxmessage "$first"
    exiting
    gxmessage 'testing'

    #  say1 "hello world"
    dereference msg_m0 

    dereference msg_m0 


elif [ $1 = delete ];then
    echo 'delete'

    delete_files 

elif [ $1 = meditate ];then
    echo 'meditate'

    $TIMER2_DIR/meditate.sh 
elif [ $1 = watchr ];then
    echo 'watchr'

    watchr $TIMER2_DIR/koans-linux.watchr 

elif [ $1 = fetch ];then
    echo 'fetching'

    $TIMER2_DIR/fetch.sh 
elif [ $1 = mail ]
then
    $TIMER2_DIR/mail.sh
elif [ $1 = english ]
then
    $TIMER2_DIR/english.sh
elif [ $1 = task ]
then

    while :; do

        . $TIMERTXT_CFG_FILE



        first=`cat $file | head -1`
         file=$TODO_FILE
        str=$(gxmessage -timeout $SLEEP -title 'next easy:' -entry -file $file )
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



        first=`cat $file | head -1`
        $timer2_sh "$first" 

########memory test

         file=$MEMORY_FILE
        
      str=$(gxmessage -timeout $SLEEP -title 'memory?' -entry -file $file )
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

echo exiting
exit
    done




elif [ $1 = all ];then # ------------------ all

        #answer=$( gxmessage "$last_task" -center  -title "title"  "$GXMESSAGE1"  )



    echo 'PLAY AGAIN    '
    let "r = $RANDOM % 4 + 1"
    counter=$r

    while :; do
        echo  "reload config file: $TIMERTXT_CFG_FILE"
        #### refresh vars ####
        . $TIMERTXT_CFG_FILE
        update_env 

        #######################
        echo "lesson is: $LESSON"

        echo "suspend is: $SUSPEND"
        echo "silence is: $silent1"
        sleep1 10s
        motivation_start 

        title="task:"
        file=$file_task
        input_line $file "$title" last_task

        time1
        echo "run all tasks: one after another"
        let "reminder = $counter % 4"
        echo "the reminder is: $reminder"
        lang="${arr1[$reminder]}"

        sport $lang 


        counter+=1

        sleep1 $sec

   title="thanks:"
        file=$file_thanks
        input_line $file "$title" last_thanks
        
        sleep1 $sec

        sleep1 $sec 
        #update_wallpaper
        #   (xdg-open 'https://www.google.com/calendar/render?tab=mc' &)
        motivation_end

        echo 'suspend..'
        sleep1 10s 
        if [ "$SUSPEND" = true ];then

            suspend1
        fi

        (xloadimage $pic_file &)
    done

fi

#if [[ $1 = learn_web ]];then
#    learn_web
#fi

pwd

popd > /dev/null
exit
#learn_book_splitter
#twitter
#youtube 
#sleep1 $sec
#learn_web
#learn_security

#kill
#http://www.linuxcommand.org/lts0080.php#listing_your_processes

#scratch linux
#http://www.linuxfromscratch.org/blfs/view/development/chapter07/network.html



