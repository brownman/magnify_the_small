#!/bin/bash
# about file:
# desc: talk to yourself and translate it
#mkdir -p $CFG_DIR/essay
#file_locker=/tmp/free_speak.lock
file_essay='x'
subject='x'
file_locker=/tmp/free_speak
notify-send "free-speak" "$0"
export STRING_TO_BUTTONS=false
random_line(){
local str=' '
random1 120
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


elif [ $num -lt 15 ];then
    str+=$(generate_line higher_self)
else
    str+=$(generate_line 'time')

    str+="|"
    str+=$(generate_line verb)

    str+="|"
    str+=$(generate_line noun)

    str+="|"
    str+=$(generate_line adv)

  

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
        str=$( gxmessage   -entrytext "$str"  -title "children story: $subject" -file "$file")
        helper0 "$str" "$file"
    done
}
change_language(){
notify-send "change language got:" "$1"
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
#notify-send 

subject="$1"
if [ "$subject" = '' ];then
    subject=$(choose_line1  'subject')
fi


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
change_filename "$1"
change_language "$2"
memory_game 
}
#unlocker 
#
#first_dialog(){
##'what do you want to do next ?'
#local str=''
#local res=0
#
#
#while [ "$str" != 'exit' ];do
#
#    str=$(gxmessage -entrytext "$str" -title 'simplest log'  -file $file_log )
#
#    if [ "$str" != '' ];then
#      
#    is_command "$str"
#    res=$?
#
#
#        if [[ $res -eq 1 ]];then
#
#        update_file $file_log "$str"
#        try "$str"
#        else
#            #helper
#
#helper0 "$str" "$file_log"
#        #update_file $file_log "+$str"
#        fi
#
#    fi
#
#
#done
#
#}
#
#first_dialog

run "$1" "$2"

