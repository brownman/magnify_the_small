#!/bin/bash
# about file:
# desc: talk to yourself and translate it
#mkdir -p $CFG_DIR/essay
#file_locker=/tmp/free_speak.lock
file_essay='x'
subject='x'
file_locker=/tmp/free_speak
notify-send "free-speak" "$0"
random_line(){
local str=''
random1 20
num=$?
#notify-send $num
if [ $num -eq 0 ];then
    str+=$(generate_line reason)
elif [ $num -eq 1 ];then
    str+=$(generate_line robot)
elif [ $num -eq 2 ];then
    str+=$(generate_line adj)
elif [ $num -eq 3 ];then
    str+=$(generate_line 'time')
elif [ $num -eq 4 ];then
    str+=$(generate_line adv)
elif [ $num -eq 5 ];then
    str+=$(generate_line trigger)
elif [ $num -eq 6 ];then
    str+=$(generate_line task)
elif [ $num -eq 7 ];then
    str+=$(generate_line bake)
elif [ $num -eq 8 ];then
    str+=$(generate_line verb)
elif [ $num -eq 9 ];then
    str+=$(generate_line grammer)
elif [ $num -lt 15 ];then
    str+=$(generate_line higher_self)
else

    str+=$(generate_line noun)

fi



#local subject=''
#
#subject=$(random_from_subject story)
#    str+=$(generate_line "$subject")
#    str+='+'
#    
#

#str='what do you want me to do'
echo "$str"
}




memory_game(){
    #file_name=${1:-'essay'}
    trace 'memory game'
    local file=$file_essay
            echo01 "why $subject is so awesome" & 
    dir=$CFG_DIR/essay/$LANG_DEFAULT
    mkdir -p $dir
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
        if [ $QUIZ = 'true' ];then
            str=$(random_line) 
        fi
        str=$( gxmessage $GXMESSAGET  -entrytext "$str"  -title "My $subject:" -file "$file")

helper0 "$str" "$file"


    done
    
}
change_language(){

local str=$( gxmessage  -entrytext "$LANG_DEFAULT" -title 'change language:' $GXMESSAGET 'pick a language:' )
if [ "$str" = '' ];then
    flite 'exiting'
    exiting
fi
export LANG_DEFAULT="$str"
local str1=$(higher "$LANG_DEFAULT")
#export LANG_NAME="$str1"
#echo01 'dog'
#echo "$str1"

}

change_filename(){
#subject='my_day'
notify-send 


subject=$(choose_line1  'subject')

local        str=$( gxmessage  -entrytext "$subject" -title 'pick a subject:' $GXMESSAGET 'new filename:' )

if [ "$str" = '' ];then
    flite 'exiting'
    exiting
else
subject="$str"
file_essay=$(generate_file "$str")
notify-send $file_essay
fi
     
}


run(){
change_filename
change_language
memory_game 
}
#unlocker 
run

