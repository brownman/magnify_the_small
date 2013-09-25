#!/bin/bash
# about file:
# desc: talk to yourself and translate it
#mkdir -p $CFG_DIR/essay
file_essay='x'

generate_line(){
local str=''
random1 2
num=$?
notify-send $num
if [ $num -eq 0 ];then
    str+=$(generate_one reason)
else
    str+=$(generate_one verb)
    str+='|'
    str+=$(generate_one adj)
    str+='|'
    str+=$(generate_one noun)
    str+='|'
    str+=$(generate_one 'time')
fi

echo "$str"
}


generate_one(){

file=$CFG_DIR/txt/${1}.txt 
touch $file
str=$( pick_line $file)
echo "$str"
}

memory_game(){
    file_name=${1:-'essay'}
    trace 'memory game'

            echo01 'how to say' & 
    dir=$CFG_DIR/essay/$LANG_DEFAULT
    mkdir -p $dir
    local file=$dir/$file_essay.txt
    touch $file
    local str=''
    local res=''
    local counter=0 
    while :;do
        let counter+=1
        if [ $QUIZ = 'true' ];then
           
            str=$(generate_line) 
            
        fi
        str=$( gxmessage  -entrytext "$str" -file $file -title "Memory: $file_essay" $GXMESSAGE0 )
        if [ "$str" = '' ];then
            local line1=$(cat $file | head -1)
            echo01 "$line1" &
        elif [ "$str" = 'exit' ];then
            flite 'breaking'
            break
        elif [ "$str" = 'listen1' ];then
               $tasks_sh learn_langs & 
           elif [ "$str" = 'read1' ];then
local lang=$(higher "$LANG_DEFAULT")
        (exo-open "http://www.goethe-verlag.com/book2/EN/EN${lang}/EN${lang}002.HTM" &)
        else
            res=$(spell2 "$str")
           if [ "$res" = 'error' ];then
               trace 'error spelling'
         
           else
              update_file $file "$res"
            (  echo01 "$res" &)
           fi
           
          
        fi
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

    local str1='quiz'
        str=$( gxmessage  -entrytext "$str1" -title 'change file_name:' $GXMESSAGET 'new filename:' )
if [ "$str" = '' ];then
    flite 'exiting'
    exiting
fi
        file_essay="$str"
        #echo "$file_essay"
}



change_filename
change_language
memory_game 
