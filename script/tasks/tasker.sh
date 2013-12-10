#!/bin/bash
# about file:
# collection of system tasks
# no gui here - remove gxmessage 
# 
notify-send 'db.sh' "$@"
#show_args "$@"
#cmd="notify-send1 'tasker.sh:' '$@'"
#every "$cmd" 10
cfg1(){
    export DEBUG=true
    notify-send 'cfg-test' 'unit..' 
    args=( "$@" )
    #$(show_args "${args[@]}") &
    res1=$(  ${args[@]} )
    echo "$res1" #must echo for testing to work
    #assert_equal_str "$res1"


}


collect_new_words(){
    #flite 'collect new words!'
    flite 'create your own conversation'
    optional "free_imagination  $DATA_DIR/txt/conversation.txt" 
    ( exo-open http://www.google.com &)
}

efficiency_report(){
    flite 'efficiency report'
    notify-send1 'efficiency report:' 'words,snippets,order'
    local res=$(    level)
    #local res=$(    check-boxes)
    #notify-send1 'efficiency level:' "$res"
    #echo "$res"
    return $res
}


impulse(){

    local   file=$DATA_DIR/txt/testing.txt 

    free_imagination $file
    #local line=$(cat $file | head -1)

}


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


free_imagination(){
    local file=${1:-"$DATA_DIR/txt/free_imagination.txt"}

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

    local cmd="tasker $str"

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

    local str="$1"
    local delimeter="$2"
    local res=$($PLUGINS_DIR/string_to_buttons.sh "$str" "$delimeter")
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

menu(){
    breakpoint
}

cow_report(){
    local table=$1
    local num=$( db counter $table)
    notify-send3 "$table.db: ++$num "
}
cow_report_txt(){
    #flite 'riddl'
    #local file=
    #local num=$( cat $DATA_DIR/txt/assosiation.txt | wc -l )
    #xcowsay "associations: $num"
    trace ''
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


    helper0 "$line" & 
    #assert_equal_str "$line"


    #    #show_file "$file_name" &
    #    echo "line: $line"
    #    cmd=cow_report
    #    every "$cmd" 2 
}

motivations(){
    notify-send3 'motivationsssss!'

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
#e
play_recent(){
    local line=$(        random_line $DATA_DIR/tmp/workflow.tmp )
    parse_line1 "$line" 
    #commander "$line"

    #update_table logger "$date1" "play_recent" "$line1"
}
play_recent2(){
    notify-send1 'play_recent2'
    local line=$(        random_line $DATA_DIR/tmp/limit.tmp )
    cmd="     limit $line "
    #update_commander
    commander "$cmd"

    #update_table logger "$date1" "play_recent" "$line1"
}

after_suspend2(){
    notify-send3 'chase your fear and they will run away from you'
    #flite "collect more koans " 

    sleep1 5
    flite 'sharing sharing sharing'
    sleep1 5
    #cow_report words &
    #sleep1 5
    motivation & 
    sleep1 5

    #limit 'tasker lpi' 60
    #reminder &
}
easiest_task(){
    local file=$DATA_DIR/txt/testing.txt
    #touch $file
    free_imagination $file &
    local  str=$(cat $file | head -1)
    flite "$str"
}


must(){
    $(    efficiency_report )
    local ans=$?
    if [ $ans -ge 0 ];then
        learn_langs &
        if [ $ans -ge 1 ];then
            git_commit &
            riddle &
            if [ $ans -ge 2 ];then
                optional increase_motivation &
                optional reminder &
            fi
        fi
    fi
}

lpi(){
    xdg-open /home/dao01/Desktop/linux-edu/LPIC1.pdf
}

suspend1(){
    local timeout=500
reminder
tasker lpi &
    sleep2 book book 120

    must &
    sleep2 suspend suspend $timeout
    if [ $ans -ne 0 ];then
        play_recent2
    fi
    notify-send1 'skip suspension for deal my fears:' '..'
    flite 'white board is awesome'
    $PLUGINS_DIR/suspend.sh
    if [ $ans -ne 0 ];then
        after_suspend2 #use it with checkboxes
    fi
}

show_progress(){
    local cmd="sleep2 '$1' '$2' '$3'"
    "$cmd"
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
    flite 'update  every cicle'
    local line="$1"
    $PLUGINS_DIR/reminder.sh "$line"
}

game_essay(){
    $PLUGINS_DIR/game_essay.sh
}

learn_langs(){
    local file=$DATA_DIR/txt/conversation.txt
    local    cmd='tasker free_imagination $file'
    optional "$cmd" &
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
    #local file=$DATA_DIR/txt/dump.txt
    local readme=$PROJECT_DIR/README.md

#    #$PROJECT_DIR/README.md
#    echo '' > $file
#
#
#    cat $DATA_DIR/md/README.md >> $file
#    #echo "- RECENT_DUMP:" >> $file
#
#
#    echo '- riddle:' >> $file
#    local res=$(db select_from_table riddle)
#    echo "$res" >>  $file
#
#    #
#    echo '- koan' >> $file
#    local res=$(db select_from_table koan)
#    echo "$res" >>  $file
#
#    cat -n $DATA_DIR/txt/child.txt >> $file
#
#    cat $file > $readme
#

    gedit $readme &
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
        update_readme &
        git add . 
        git commit -am "$answer"


        $(messageYN1 'push to remote?' 'github' )
        answer=$?

        if [[ $answer -eq 1 ]];then
            git push origin develop 
            exo-open 'https://github.com/brownman/magnify_the_small' &
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

##works:
args=( "$@" )
$(show_args "${args[@]}")
res1=$(  "${args[@]}" )
echo "$res1" #must echo for testing to work
#assert_equal_str "$res1"
############################### proxy for execution #####################


