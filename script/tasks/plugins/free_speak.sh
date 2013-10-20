#!/bin/bash
# about file:
# desc: talk to yourself and translate it
#mkdir -p $CFG_DIR/essay
#file_locker=/tmp/free_speak.lock

notify-send "free-speak" "$0"
file_essay='x'
subject='x'

delay=5
file_locker=/tmp/free_speak

export STRING_TO_BUTTONS=false

random_line(){
local str=' '
random1 3
num=$?

#notify-send $num
if [ $num -eq 0 ];then

    str+=$(generate_line 'time')

    str+="|"
    str+=$(generate_line verb)

    str+="|"
    str+=$(generate_line noun)

    #str+="|"
    #str+=$(generate_line adv)

fi


echo "$str"
}




memory_game(){
    #file_name=${1:-'essay'}
    notify-send 'memory game'
    local file=$file_essay
 

            echo01 "why $subject is so awesome" & 
    #dir=$CFG_DIR/essay/$LANG_DEFAULT
    #mkdir -p $dir
    #local file=$dir/$file_essay.txt
    #touch $file
    local str=''
    local result=0
    local counter=0 

     local line1='' 
       is_valid "$file"
        result=$?
        trace 'result is: '
        trace $result
        if [[ $result -eq 1  ]];
        then

        line1=$(cat $file | head -1)
    else
        line1='start'
        fi

    while :;do
        let counter+=1
        sleep1 5
        notify-send "loop" "$counter"
        if [ "$QUIZ" = 'true' ];then
            str=$(random_line) 
        fi
        str=$( gxmessage   -entrytext "$str"  -title "children story: $subject" -file "$file")
        helper0 "$str" "$file"
    done
}
change_language(){
notify-send "change language got:" "$1"
local str=$( gxmessage  -entrytext "$LANG_DEFAULT" -title 'change language:' $GXMESSAGET 'pick a language:' )
if [ "$str" != '' ];then
    export LANG_DEFAULT=$str

local str1=$(higher "$LANG_DEFAULT")
fi


#export LANG_NAME="$str1"
#echo01 'dog'
#echo "$str1"

}

change_filename(){
#subject='my_day'
#notify-send 

subject=""
if [ "$subject" = '' ];then
    subject=$(choose_line1  'subject')
fi


local        str=$( gxmessage  -entrytext "$subject" -title 'pick a subject:' $GXMESSAGET 'new filename:' )

if [ "$str" != '' ];then
subject="$str"
fi


local file=$DATA_DIR/txt/$subject.txt 
touch $file

    if [ -f $file ];then
        notify-send "valid" "$file"
  file_essay=$file
memory_game 
    else
        notify-send "in-valid" "$file"
    fi
  
#gxmessage -file $file_essay $GXMESSAGET
}


run(){
change_filename "$1"
#change_language "$2"

}
#run "$1"
#"$2"
unlocker
