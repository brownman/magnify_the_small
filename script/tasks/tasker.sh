#!/bin/bash
# about file:
# collection of system tasks
# no gui here - remove gxmessage 
# 

notify-send "tasker.sh:" "$@"




do_koan(){
#local dir_source=$PWD/1/testing/python2/koans

local dir_source=$dir_koans
local file_name_target="recent_koan.py" 
update_recent_link "$dir_source" "$file_name_target"
}

do_abs(){
#local dir_source=$PWD/1/testing/python2/koans
local dir='~/magnify_the_small/1/others/CODE/abs-guide-6.5'
local line=$(generate_line 'abs')
local res="$dir/$line"

    COMMANDER=true


#commander  "exec $res"

cmd="gedit $res"
commander "$cmd" 

echo 'z'

}

#notify-send "tasker.sh:" "$*"
article(){

    local file="$1"
    $PLUGINS_DIR/article/commands.sh "$file"
}

google(){
    $PLUGINS_DIR/google.sh "$1"
}


task_from(){
    notify-send "picker got" "$@"

    local name="$1" #
    local num="$2" #
    local file1=$DATA_DIR/tmp/${name}.tmp
    mantion_file $file1
    local str=''
    if [ "$num"  = '' ];then
        str=$(zenity1 $file1)
    else
        lines=()
        file_to_lines $file1 
        str=$(echo ${lines[$num]})

    fi

    local cmd="$tasks_sh $str"

    #assert_equal_str "$cmd"
    #assert_equal_str "$cmd"
    eval "$cmd" & 
}

ask_a_question(){
    notify-send 'ask! and learn!'
}

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
    #notify-send 'string_to_buttons'
    local str1="${FUNCNAME[0]}"

    local str="$1"
    #assert_equal_str "$str" "$str1" 
    local delimeter="$2"
    local cmd="$PLUGINS_DIR/string_to_buttons.sh '$str' '$delimeter'"
    res=$(eval "$cmd")
    #local res=$($PLUGINS_DIR/string_to_buttons.sh "$str" "$delimeter")
    #1" "$2" "$3")
    echo "$res"
}

free_speak(){
    $PLUGINS_DIR/free_speak.sh 
    #"$1" 
    #"$2"
}

nothing(){
    trace "nothing got: $1"
    echo "$1"
}

rules(){
    #gxmessage $GXMESSAGET -file 
    zenity1 $DATA_DIR/tmp/notes.tmp

}

recent_video(){
    export COMMANDER=true
    str='vlc /TORRENTS/VIDEO1/SecurityTube.Python.Scripting.Expert/Module-01/02.m4v'
    commander "$str"
}

take_photo(){
    $PLUGINS_DIR/take_photo.sh
}

increase_motivation(){
    $PLUGINS_DIR/increase_motivation.sh
}



update_db(){
    local  table1="$1"

  local choose=''
  local choose1=''
    #update_db_list
    if [ "$table1" = '' ];then
        table1=$(zenity1 "$DATA_DIR/txt/db.txt")
    fi

    if [ "$table1" ];then
   choose=$(show_selected_table "$table1")
    #local choose1=$(echo "$choose" | awk -F '|' '{print $3}')
    #echo01 "$choose1"
 choose1=$(string_to_buttons "$choose" '|')
    fi
    #assert_equal_str "$choose1"
    echo01 "$choose1" &

    echo "$choose"

  
}

#
#menu(){
#
##notify-send 'show the menu'
#
#local dir1=$SCRIPT_DIR/time
#    local title='execute:'
#    local text='list dir:'
#
#
#
#
#    local file=$( list_dir $dir1 "$title" "$text" false )
#    local choose=${dir1}/${file}
#    local res=0
#     
#    if [ "$choose" != '' ];then
#        
#        #messageYN1 "$file"
#      local  res=1
#        #$?
#        
#        if [[ $res -eq 1 ]];then
#         /usr/bin/xterm -e "$choose"
#        sleep1 3 
#    fi
#
#       
#    fi
#    echo 'end'
#}
#
#
cow_report(){
local num=$( cat $DATA_DIR/txt/assosiation.txt | wc -l )
xcowsay "associations: $num"
}


motivation(){
notify-send1 'motivation'
caller1
    file_name="$1"
cmd=cow_report
every "$cmd" 10
    reason='push: learning new language'
local line=''

        random1 10
        ans=$?
        if [ $ans -gt 3 ];then
             line=$(generate_line glossary)
        else
             line=$(generate_line sport)
        fi

echo01 "$line"

    #assert_equal_str "$line"
    reasoning 


}

motivations(){
    notify-send 'motivations!'
    #echo "hello"
    #if [ $MUTE = false ];then
    #echo "bbb"

    #file_name="$1"
    #local file_name=${1:-'glossary'}
    #local line=$(generate_line $file_name)
    #$CFG_DIR/txt/$file_name.txt
    local cmd="$PLUGINS_DIR/translation.sh lines $DATA_DIR/txt/glossary.txt true"
    #COMMANDER=true
    commander "$cmd"
    echo "$motivations"
    #fi
    #echo 'end'
}


scrap(){

    local lang=$1 
    local word=$2 
    local word1=''
    trace "word: $word"


    word1=$(echo "$word") 
    $PLUGINS_DIR/scrap.sh translate $lang "$word1" 
    #exo-open /TORRENTS/html/


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

before_suspension(){
notify-send1 'before_suspension'
flite 'think smaller'
sleep1 5
motivation

cmd=free_speak
every "$cmd" 10

cmd=learn_langs
every "$cmd" 15
}

suspend1(){
    #flite "should - $msg"

   before_suspension 

    local timeout=440
    sleep1 $timeout


    $PLUGINS_DIR/suspend.sh


    flite 'update your notebook'

    #motivation 
    #xterm1 reminder &
    #local cmd='after_suspension'
   #"$cmd" &
   after_suspension 


   notify-send1 'exiting func' 'suspend()'
   breakpoint
}

show_progress(){
    local cmd="sleep2 '$1' '$2' '$3'"
    "$cmd"
}

add_association(){
update_db associations
}

after_suspension(){
   push_order_forward 
   #free_speak 
   update_db the_big_picture

   gedit $DATA_DIR/yaml/priorities.yaml & 

}

report(){
    echo 'update google blogger with the score for this cycle'
}

collaboration(){
    #(      \'xterm1 $PLUGINS_DIR/collaboration.sh &)
    $PLUGINS_DIR/collaboration.sh 
    #sleep1 30
}

reminder(){
    notify-send1 'reminder'
    $PLUGINS_DIR/reminder.sh 
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

scp_android(){
    $(messageYN1 'backup db to android device ?' 'backup'  )
    answer=$?

    if [[ $answer -eq 1 ]];then
        $PLUGINS_DIR/android.sh 
    else
        echo 'skip backup'
    fi



}
git_commit(){
    local answer=$(    gxmessage $GXMESSAGET -entry  "git commit ?" )
    if [ "$answer" ];then
git rm -r --cached .
        git add .
        git commit -am "$answer"

    fi
    $(messageYN1 'push to remote?' 'github' )
    answer=$?

    if [[ $answer -eq 1 ]];then
        git push origin develop 
        exo-open 'https://github.com/brownman/magnify_the_small'
    else
        echo 'skip pushing'
        
    fi
}

push_order_forward(){
    update_db "priorities"
}
deal_comparison(){
$PLUGINS_DIR/deals.sh
}


############################### proxy for execution #####################
#export COMMANDER=true
cmd1="$@"
res1=$(eval "$cmd1")
echo "$res1"

############################### proxy for execution #####################


