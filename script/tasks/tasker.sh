#!/bin/bash
#-e
# about file:
# collection of system tasks
# no gui here - remove gxmessage 
# 

notify-send "tasker.sh:" "$*"

#notify-send "tasker.sh:" "$*"

random_quote(){
    local res=$( $PLUGINS_DIR/random_quote.sh )
    echo "$res"
}
show_msg(){
    trace "show_msg $1: $2"
    local msg=$( gxmessage $GXMESSAGET "$1" -title "$2" -entry )
    #commitment "$msg"
    echo "$msg"
}
#show_msg_entry(){
#
#    trace 'show_msg_entry' "show_msg_entry subject : $1"
#    notify-send 'show_msg_entry' "show_msg_entry - subject: $1"
#    local subject="$1"
#    #parse_subject "$subject"
#    local file=$(get_filename1 $subject)
#    notify-send "FILE RECENT" "$file"
#    local str1=$(cat $file | head -1)
#    local msg=$( gxmessage -file $file -entrytext "$str1" $GXMESSAGET  -title "$subject"  )
#    if [ "$msg" = '' ];then
#        motivation glossary
#    else
#        trace 'echo 01'
#        echo "$msg" >> $CFG_DIR/txt/easy.txt
#        echo01 "$msg" &
#        #flite "$msg"
#    fi
#    echo "$msg"
#}
practice_regexp(){
#http://linux.die.net/Bash-Beginners-Guide/sect_04_02.html#sect_04_02_02

local exp=${1:-'\<c...h\>'}

exp=$(gxmessage $GXMESSAGET -entrytext "$exp" -title 'practice!' 'Enter RegExp:' )

local file=/usr/share/dict/words
local file_tmp=/tmp/regexp
local res=$(grep "$exp" "$file")
#gxmessage $GXMESSAGET "$res" -title "$exp"

echo "$res" > $file_tmp
local str=$(zenity1 "$file_tmp")
echo01 "$str"
}

string_to_buttons(){
local str="$@"
local str1="${FUNCNAME[0]}"
    #assert_equal_str "$str" "$str1" 
    local delimeter=' '
    local res=$($PLUGINS_DIR/string_to_buttons.sh "$str" "$delimeter")
    #1" "$2" "$3")
    echo "$res"
}

free_speak(){
    $PLUGINS_DIR/free_speak.sh
}

nothing(){
    trace "nothing got: $1"
    echo "$1"
}



take_photo(){
     $PLUGINS_DIR/take_photo.sh
}


menu(){

#notify-send 'show the menu'

local dir1=$SCRIPT_DIR/time
    local title='execute:'
    local text='list dir:'




    local file=$( list_dir $dir1 "$title" "$text" false )
    local choose=${dir1}/${file}
    local res=0
     
    if [ "$choose" != '' ];then
        
        #messageYN1 "$file"
      local  res=1
        #$?
        
        if [[ $res -eq 1 ]];then
         /usr/bin/xterm -e "$choose"
        sleep1 3 
    fi

       
    fi
    echo 'end'
}




motivation(){
    file_name="$1"

   reason='push: learning new language'

    reasoning 
trace "motivation: $file_name : $MUTE"
    if [ "$MUTE" = false ];then
        random1 10
        ans=$?
        #notify-send "random: $ans"
        if [[ $ans -gt 3 ]];then
            local file=$(generate_file $file_name)
            
            $PLUGINS_DIR/translation.sh line $file false   
        else
            local file=$(generate_file sport)
            $PLUGINS_DIR/translation.sh line $file false   
        fi
    fi
}

motivations(){

    #echo "hello"
    if [ $MUTE = false ];then
        #echo "bbb"

        #file_name="$1"
        local file="$1"
        #$CFG_DIR/txt/$file_name.txt
        local msg=$( $PLUGINS_DIR/translation.sh lines $file false   )
        echo "$msg"
    fi
    #echo 'end'
}


scrap(){

    local lang=$1 
    local word=$2 
    local word1=''
    trace "word: $word"


    word1=`echo "$word"`
    $PLUGINS_DIR/scrap.sh translate $lang "$word1" 


}

koan(){
    yellow 'add 1 koan !'
    ( bash -c $KOANS_DIR/meditate.sh &)
}


record_for_later(){
    xdg-open 'http://www.youtube.com/upload'
}


show_file(){

    local    file="$1"

    $(messageYN1 'edit file ?' 'show_file' '-iconic' )
    answer=$?

    if [[ $answer -eq 1 ]];then
        gedit $file
    else
        echo 'skip editing'
    fi

}

show_file_html(){
    local    file="$1"
    string_to_buttons_file 'cancel edit' '2 options' $file
    answer=$?

    if [[ $answer -eq 1 ]];then
        exo-open $file
    else
        echo 'skip editing'
    fi

}

show(){
    trace "show() got: $1 $2"
    local name="$1"

    flite "minimizinged file" # - $name"
    local file=$CFG_DIR/txt/$name.txt
    touch $file
    show_file "$file"
}

time1(){
    date1="$(date +%H:%M)"
    ( gxmessage  -buttons "_$last_task" "time: $date1"  -sticky -ontop -font "serif bold 74" -timeout $TIMEOUT1 &)
    echo4 "$date1"
}

update(){
    cyan "update:"
    title="NOW DOING:"
    file=$now_txt
    add_line $file "$title" true #add time note 
    tile="EFFICIENT COMMITMENT:"
    file=$ideas_txt
    add_line $file "$title"
}


suspend1(){
    #local msg=`cat public/cfg/blank.yaml | shyaml get-value frame.should`
    #flite "should - $msg"



    $PLUGINS_DIR/suspend.sh


    flite 'update your notebook'

    motivation sport

}

#generate_file(){
#    local subject=$1
#    local file=$2
#    $PLUGINS_DIR/yaml_parser.sh generate_file $subject $file
#}

report(){
    echo 'update google blogger with the score for this cycle'
}

collaboration(){
    #(      \'xterm1 $PLUGINS_DIR/collaboration.sh &)
    $PLUGINS_DIR/collaboration.sh 
    #sleep1 30
}

commitment(){
    local res=$($PLUGINS_DIR/commitment.sh "$1" )
    echo "$res"
}

game_essay(){
    $PLUGINS_DIR/game_essay.sh
}

learn_langs(){
    $PLUGINS_DIR/learn_langs.sh play_lesson 
}


update_row(){

    #export COMMANDER=true
local name="$1"
local cmd=$(echo "zenity1 $DATA_DIR/txt/${name}.txt $name 'be smarter' " )
local str=$(eval $cmd   )
#local str=$(commander "$cmd")
        #- cfg|zenity1|$DATA_DIR/txt/glossary.txt,'glossary','be smarter','--editable'|dd
        #echo01 "$str"

    echo "update_row: $str"
    } 
    

############################### proxy for execution #####################
#export COMMANDER=true
cmd1="$@"
res1=$(commander "$cmd1")
echo "$res1"

############################### proxy for execution #####################

