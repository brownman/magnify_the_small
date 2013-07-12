#!/bin/bash

# about file:
# run task in circle
#
. $TIMERTXT_CFG_FILE
#update_lang it


series1(){

    . $TIMERTXT_CFG_FILE
    local series="$1"
    local yno=""
    IFS=', ' read -a array <<< "$series"

    #echo "${array[0]}"
    #echo $str
    for index in "${!array[@]}"
    do
        green "current task: $index" 

        #$yno=`eval ${array[index]}`
        yno=`echo ${array[index]}`


        echo "$series" | grep $yno

        case $yno in
            "input_task")
                title="task:"
                file=$task_txt
             $timer_sh input_line $file "$title" last_task

                ;;
           "speak")
                $timer_sh speak
                ;;
            "remind_me")
                say1 $msg_remind_me 
                ;;
            "time")
                time1
                ;;
            "motivation_start")
                $timer_sh motivation_start
                ;;
            "sleep")
                sleep1 $SLEEP
                ;;
            "mindmap")
                answer=$( messageYN "y/n question" "open mind map link ?" )
                if [ "$answer" = 2 ];then

                    xdg-open $mm_link &
                fi
                ;;
            "show_done")
                gxmessage  -title 'how to say..' -file $done_txt -timeout 30 
                ;;
            "show_todo")
                gxmessage  -title 'how to say..' -file $todo_txt -timeout 30 
                ;;
            "glossary")
                ( gxmessage  -title 'how to say..' -file $glossary_txt -timeout 30 &)
                write_essay "$LANG_ESSAY"
                ;;
            "suspend")
                $timer_sh suspend
                ;;
            "rules")
                echo2 'update rules'
                messageANS "update rules" "$rules_txt" 
                ;;
            "one_task")
                one_task1
                ;;
            "schedule")
                xdg-open 'https://www.google.com/calendar/render?tab=mc'
                ;;

            "edit")
                #( xterm -e 
                ( "$TASKS_DIR/edit.sh" &)
                ;; 

            *) red "Invalid task:"
                yellow "$yno"
                ;;
        esac     
sleep1 15
    done
    exit

    #answer=$( gxmessage  "$last_task" -center  -title "title"  "$gxmessage 1"  )


}






while :;do
    series1 "edit,speak,input_task,sleep,suspend" #,motivation_start,input_task"
    sleep1 1
done
