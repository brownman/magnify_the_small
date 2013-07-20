#!/bin/bash

# about file:
# run task in circle
#
. $TIMERTXT_CFG_FILE
#update_lang it

source $tasks_sh
workflow=''
workflow_d=''

series1(){

    . $TIMERTXT_CFG_FILE

    local series="$1"
    local series_d="$2"
    local yno=""
    IFS=',' read -a array <<< "$series"
    IFS=',' read -a array_d <<< "$series_d"

    #echo "${array[0]}"
    #echo $str
    for index in "${!array[@]}"
    do



        #$yno=`eval ${array[index]}`

        yno=`echo ${array[index]}`
        yno_d=`echo ${array_d[index]}`

        echo4 "$yno_d" &
        notify-send "$index: $yno" "$yno_d"

        echo "$series" | grep $yno

        case $yno in
  "store_ideas")
                $tasks_sh store_ideas 
                ;; 

  "scrap_practice")
                $tasks_sh scrap_practice 
                ;; 


            "glossary_reminder")
                $tasks_sh glossary_reminder
                ;;

            "morning_reminder")
                $tasks_sh morning_reminder
                ;;
            "motivation_random")
                $tasks_sh motivation_random
                ;;
            "remind_workflow")

                echo '' 
                ;;
            "input_task")
                title="current task:"
                $tasks_sh input_line $now_txt "$title" 

                ;;
            "speak")
                $tasks_sh speak
                ;;
            "remind_me")
                say1 $msg_remind_me 
                ;;
            "time")
                time1
                ;;
            "motivation_start")
                $tasks_sh motivation_start
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
                $tasks_sh suspend
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
            "delete")
                $tasks_sh delete_files 
                ;; 
            "edit")
                #( xterm -e 
                ( "$TASKS_DIR/edit.sh" &)
                ;; 
   

            *) 
                red "Invalid task:"
                yellow "$yno"
                ;;
        esac     
    done
}



read_lines(){
    echo2 'read_lines()'
    local file_guide="$1"
    old_IFS=$IFS
    IFS=$'\n'
    lines=($(cat $file_guide)) # array
    IFS=$old_IFS
    for line in "${lines[@]}"
    do
        echo "$line "
        if [ "$line" = '#' ];then
            break
            #red 'empty line'  
        else
            desc=$( echo $line | awk -F '|' '{print $2}' )
            command=$( echo $line | awk -F '|' '{print $1}' )
            workflow="$workflow,$command"
            workflow_d="$workflow_d,$desc"
            #red "workflow_d: $workflow_d"
        fi
    done

}



read_lines $CFG_DIR/workflow.txt
#red "$workflow"
series1  "$workflow" "$workflow_d"  
