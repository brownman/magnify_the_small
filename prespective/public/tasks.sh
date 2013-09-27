#!/bin/bash
# about file:
# collection of system tasks
# no gui here - remove gxmessage 
# 
trace "tasks.sh got: "  
trace "1: $1"  
trace " 2:$2 3:$3 4: $4"  

helper(){
    export DEBUG=true
    local result=''
    local str='where do you desire to visit ?'
    local title='imagine'
    local file=$file_bake
    local help="take_photo|"


    local line=$(pick_line $file)
        #local ans=$( gxmessage  -entrytext "$line"  $GXMESSAGET  -title "$title" -file "$file" )
        #result=$(eval 'think "$ans"')
    gxmessage "$line" $GXMESSAGET
    flite "$line"
    echo01 "$line"
}
think(){
    local ans="$1"
    if [ "$ans" = 'help' ];then
            str="$help" 
        elif  [ "$ans" = 'exit' ];then
            flite 'breaking'
            break
        elif [ "$ans" = '' ];then
            #$tasks_sh motivation 
  flite 'breaking'
            break
        else


            #result=$(commander "$ans")
            notify-send "$ans"
        fi
        echo "$result"
}
#cake(){
#
#    $(random1 10)
#
#    local    ans=$?
#    #echo "$ans"
#
#    notify-send "show_line:$ans"
#    local ans1=$(fetching frame.cake)
#
#    local ans2=$(    cat "$file_recent" | head -2 )
#    #echo "$ans1"
#    echo "$ans2"
#
#}


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
show_msg_entry(){
    trace 'show_msg_entry' "show_msg_entry $1: $2"
    #local str=$(pick_line $CFG_DIR/txt/glossary.txt )
    local str=$(cat $file_recent | head -1)
    str1=$( echo $str | awk -F '|' '{print $2}' )
    if [ "$str1" = '' ];then
        str1="$str"
    fi
     
    local msg=$( gxmessage -file $file_recent -entrytext "$str1" $GXMESSAGET  -title "$2"  )
    if [ "$msg" = '' ];then
        motivation glossary
    else
        trace 'echo 01'
        echo "$msg" >> $CFG_DIR/txt/easy.txt
        echo01 "$msg"
        #flite "$msg"
    fi
}

string_to_buttons(){
    local res=$($PLUGINS_DIR/string_to_buttons.sh "$1" "$2" "$3")
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
    xterm1 $PLUGINS_DIR/take_photo.sh
}

motivation(){
    file_name="$1"

    if [ $MUTE = false ];then
        random1 10
        ans=$?
        #notify-send "random: $ans"
        if [[ $ans -gt 3 ]];then
            local file=$(generate_line $file_name)
            $PLUGINS_DIR/translation.sh line $file false   
        else
            local file=$(generate_line sport)
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

generate_file(){
    local subject=$1
    local file=$2
    $PLUGINS_DIR/yaml_parser.sh generate_file $subject $file
}

report(){
    echo 'update google blogger with the score for this cycle'
}

collaboration(){
    #(      \'xterm1 $PLUGINS_DIR/collaboration.sh &)
    $PLUGINS_DIR/collaboration.sh 
    #sleep1 30
}

commitment(){
    $PLUGINS_DIR/commitment.sh "$1"  
    #$PLUGINS_DIR/stop_watch.sh 
}

game_essay(){
    $PLUGINS_DIR/game_essay.sh
}

learn_langs(){
    $PLUGINS_DIR/learn_langs.sh play_lesson 
}



eval "$1" '"$2" "$3"'


