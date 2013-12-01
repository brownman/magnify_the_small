#!/bin/bash
# about file:
# collection of system tasks
# no gui here - remove gxmessage 
# 
notify-send 'tasker.sh' "$@"
#show_args "$@"
#cmd="notify-send1 'tasker.sh:' '$@'"
#every "$cmd" 10
children_story(){
notify-send1 'children story'

    url1='http://teaching-tales.org/'
url2='http://www.mamalisa.com/'


    exo-open "$url1" &
    exo-open "$url2" &
free_speak child &
}
riddle(){
$PLUGINS_DIR/riddle.sh 
}


#
#add_koan(){
#local res=$( $PLUGINS_DIR/add_koan.sh )
#echo "$res"
#}
simple(){
#local first="$1"


#local arg="$1"
#assert_equal_str "$arg"
$(eval show_args "$1" "$2" "$3")

local res=$(echo "$1")
#assert_equal_str "$res"
    #args=(a),
    #show_args "${@}"
#local arg=$( echo  "$1")

#echo "$res"
echo "a b"
#echo "$first"


}

free_imagination(){
    file=${1:-"$DATA_DIR/txt/free_imagination.txt"}

    $PLUGINS_DIR/free_imagination.sh "$file"
}

do_koan(){
    #local dir_source=$PWD/1/testing/python2/koans

    local dir_source=$dir_koans
    local file_name_target="recent_koan.py" 
    update_recent_link "$dir_source" "$file_name_target"

 cat $LINKS_DIR/recent_koan.py | head -10
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
    #mantion_file $file1
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


string_to_buttons1(){
echo hi
}
string_to_buttons(){
    #notify-send1 'string_to_buttons'
    #local str1="${FUNCNAME[0]}"


#eval 'show_args "$1" "$2"'


local str="$1"
#$(eval echo $1)
#assert_equal_str "$str"
#( echo "$1")

    local delimeter="$2"

#eval 'show_args "$str" '

    #local args=( "$@" )
    #assert_equal_str "$str"

    #local cmd=$(echo "$PLUGINS_DIR/string_to_buttons.sh $1 $2")
    #local cmd=$(echo "$PLUGINS_DIR/string_to_buttons.sh '$str' '$delimeter'")
    #local res=$( commander "$cmd" )


    local res=$($PLUGINS_DIR/string_to_buttons.sh "$str" "$delimeter")
    #1" "$2" "$3")
    echo "$res"
}

free_speak(){
    local subject="$1"
    $PLUGINS_DIR/free_speak.sh "$subject" 
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
    str='vlc /TORRENTS/VIDEO1/SecurityTube.Python.Scripting.Expert/Module-01/02.m4v'
    commander "$str"
}

take_photo(){
    $PLUGINS_DIR/take_photo.sh
}

increase_motivation(){

    $PLUGINS_DIR/increase_motivation.sh
}

db(){
#notify-send1 'db' "$@"

##works:
local args=( "$@" )
#$(show_args "${args[@]}")
local res1=$(   $PLUGINS_DIR/db.sh   "${args[@]}")
echo "$res1" #must echo for testing to work
#assert_equal_str "$res1"
############################### proxy for execution #####################


  
}

#update_db(){
#    local  table1="$1"
#
#    local choose=''
#    local choose1=''
#    #update_db_list
#    if [ "$table1" = '' ];then
#        table1=$(zenity1 "$DATA_DIR/txt/db.txt")
#    fi
#
#    if [ "$table1" ];then
#
#        choose=$(update_table_gui1 "$table1")
#        #choose=$(show_selected_table "$table1")
#        #local choose1=$(echo "$choose" | awk -F '|' '{print $3}')
#        #echo01 "$choose1"
#        #choose1=$(string_to_buttons "$choose" '|')
#    fi
#    #assert_equal_str "$choose1"
#    #echo01 "$choose1" &
#
#    echo "$choose"
#
#
#}
menu(){
breakpoint
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
    #flite 'riddl'
    #local file=
    #local num=$( cat $DATA_DIR/txt/assosiation.txt | wc -l )
    #xcowsay "associations: $num"

    num=$( db counter riddle)
    xcowsay "riddles: $num"


}


motivation(){

    #notify-send1 'motivation'
    #caller1
    subject="$1"
    cmd=cow_report
    every "$cmd" 3 
    reason='push: learning new language'
    local line=''

if [ "$subject" = '' ];then
    random1 10
    ans=$?
    if [ $ans -gt 3 ];then
        line=$(random_from_subject1 glossary)
    else
        line=$(random_from_subject1 sport)
    fi


else

    line=$(random_from_subject1 "$subject")
#assert_equal_str "$line"

fi


    echo01 "$line" &
    #assert_equal_str "$line"


  #show_file "$file_name" &
  echo "line: $line"
    cmd=cow_report
    every "$cmd" 2 
}

motivations(){
    notify-send3 'motivationsssss!'
    #echo "hello"
    #if [ $MUTE = false ];then
    #echo "bbb"

    #file_name="$1"
    #local file_name=${1:-'glossary'}
    #local line=$(generate_line $file_name)
    #$CFG_DIR/txt/$file_name.txt
    local cmd="$PLUGINS_DIR/translation.sh lines $DATA_DIR/txt/glossary.txt true"
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

#before_suspension(){
#    notify-send1 'before_suspension'
#    flite 'think smaller'
#    sleep1 5
#    motivation
#
#    cmd=free_speak
#    every "$cmd" 10
#
#    cmd=learn_langs
#    every "$cmd" 15
#}
play_recent(){
    local line=$(        random_line $DATA_DIR/tmp/workflow.tmp )
   parse_line1 "$line" 
    #commander "$line"

            #update_table logger "$date1" "play_recent" "$line1"
}
#remind_1_task(){
#    notify-send1 'funniest story ever !'
#
#    #line=$(pick_random_line $DATA_DIR/tmp/task.tmp)
#    local line=$(cat  $DATA_DIR/tmp/task.tmp | head -1)
#    local line1=$(gxmessage "$line" $GXMESSAGET)
#    notify-send1 "$line1"
#    #local subject=$(string_ws "$line")
#    #free_speak "$subject"
#    #echo 'random task'
#}

suspend1(){
    #flite "should - $msg"


cmd='git_commit'

every "$cmd" 
            play_recent & 
            sleep1 10
    motivation & 


    local timeout=440
    sleep1 $timeout

    $(messageYN1 '2 ways' 'push 1 fear forward ?')
    res=$?
if [ "$DICE" = true ];then
   if [ $res -eq 1 ];then

        random1 2
        res=$?
        #local strr='go away from the computer and let me to decide what to do now'
        #notify-send3 "$strr"
     
        
        if [ $res -eq 0 ];then
            $PLUGINS_DIR/suspend.sh
        else

            learn_langs &
sleep1 5


   flite 'collect new words!'



        ( exo-open http://www.google.com &)

   flite 'take 30 seconds'
        sleep1 31
        #cmd="xterm1 free_speak new_words"
        #(eval "$cmd" &)


            notify-send1 'skip suspension for deal my fears:' '..'


            $PLUGINS_DIR/suspend.sh

        #( free_speak new_words &)
            

        fi
    else

        $PLUGINS_DIR/suspend.sh
    fi



    
else
    
        $PLUGINS_DIR/suspend.sh
fi
 


#remind_1_task


    flite 'update your notebook'


    #xterm1 reminder &
    #local cmd='after_suspension'
    #"$cmd" &

    #   cmd=before_suspension 
    #   every "$cmd" 5
    #cmd=after_suspension 
    #every "$cmd" 1 
    #after_suspension &
    reminder &
    notify-send1 'exiting func' 'suspend()'
    sleep1 5
    
}
#planning(){
#
#    update_db_gui the_big_picture
#}
show_progress(){
    local cmd="sleep2 '$1' '$2' '$3'"
    "$cmd"
}

#add_association(){
#    update_db associations
#}
#
#after_suspension(){
#    notify-send 'after_suspension()'
#    #push_order_forward 
#    #free_speak 
#
#    gedit $DATA_DIR/yaml/priorities.yaml & 
#    #update_db the_big_picture
#
#
#    notify-send1 'sleep 10 sec' ' - exit suspend'
#    sleep1 10
#
#}
#
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
    local line="$1"
    $PLUGINS_DIR/reminder.sh "$line"
}

game_essay(){
    $PLUGINS_DIR/game_essay.sh
}

learn_langs(){
    local file=$DATA_DIR/txt/conversation.txt
    free_imagination $file &
    $PLUGINS_DIR/learn_langs.sh play_lesson 
}


update_row(){

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
update_readme(){
local file=$DATA_DIR/txt/dump.txt
local readme=$PROJECT_DIR/README.md

#$PROJECT_DIR/README.md
echo '' > $file


cat $DATA_DIR/md/README.md >> $file
#echo "- RECENT_DUMP:" >> $file


echo '- riddle:' >> $file
local res=$(db select_from_table riddle)
echo "$res" >>  $file

#
echo '- koan' >> $file
local res=$(db select_from_table koan)
echo "$res" >>  $file

cat -n $DATA_DIR/txt/child.txt >> $file

cat $file > $readme


gedit $file &
}
homework(){
    local dir=$DATA_DIR/homework/linux-edu
local res=$(pick_file "$dir" )
xdg-open "$res"

}


git_commit(){
    local answer=$(    gxmessage $GXMESSAGET -entry  "git commit ?" )
    if [ "$answer" ];then
        git rm -r --cached .
        update_readme
        git add .
        git commit -am "$answer"


        $(messageYN1 'push to remote?' 'github' )
        answer=$?

        if [[ $answer -eq 1 ]];then
            git push origin develop 
            exo-open 'https://github.com/brownman/magnify_the_small'
        else
            echo 'skip pushing'

        fi

    fi
}

push_order_forward(){
    update_db "priorities"
}
deal_comparison(){
    $PLUGINS_DIR/deals.sh
}


############################### proxy for execution #####################


#show_args ${}"$@"

 #show_args 'a a' 'b' 'cc c' 
 #show_args "$1" "$2" "$3"
#COMMANDER=false
#eval show_args "${args[0]}" "${args[1]}" "${args[2]}"
#cmd=$(eval show_args "${args[@]}")
#res1=$(commander "$cmd")
#cmd=$( eval echo "${args[@]}")
#cmd="$@"
#$(echo "$@")
#res1=$( commander "$cmd" )

##works:
args=( "$@" )
#$(show_args "${args[@]}")
res1=$( "${args[@]}")
echo "$res1" #must echo for testing to work
#assert_equal_str "$res1"
############################### proxy for execution #####################


