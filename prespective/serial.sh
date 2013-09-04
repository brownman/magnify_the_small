# about file:
# run circle of tasks: 
# input: workflow.txt
# execute: tasks.sh $workflow
#




increase_efficiency(){


    count="$1"
    max="$2"
    task="$3"
    local str2="$count of $max"
    gxmessage "$str2" -title "Efficiency Report" $GXMESSAGET  -buttons 'low:0,medium:1,high:2' "Task: $task"  
    local level="$?"
    local file1=$4
    #CFG_DIR/txt/efficiency.txt
    echo "level: $level"
    echo "##$task:$level" >> $file1
    #gedit $file1
}

read_lines(){
    trace "read_lines() got:  1:$1 2:$2"
    local file_guide="$1"
    local waiting="$2"

    while read -r line
    do
        [[ $line = \#* ]] && continue
        #echo "$line"
        #lines=("${lines[@]}" "$line")
        if [ "$line" != ''  ];then
            #echo "line: $line"
            lines+=("$line")
        fi
    done < "$file_guide"


    #echo "lines: ${lines}"

    max=${#lines[@]}
    count=1

    for line in "${lines[@]}"
    do


        echo "$line "
        action=$( echo $line | awk -F '|' '{print $1}' )
        args0=$( echo $line | awk -F '|' '{print $2}' )

        args=$($tasks_sh fetch "$args0")
        desc=$( echo $line | awk -F '|' '{print $3}' )
        notify-send "TASK: $desc" "$args"
        flite "$desc" true
        if [[ $count -eq 1 ]];then
            $tasks_sh "$action" "$args" "$desc" 
        else
            local title="task: $count/$max" 
            local msg="$desc ?"
            $(messageYN1 "$msg" "$title")
            local result=$?
            trace "continue? $result"
            if [[ $result -eq 0 ]];then
                flite 'exit workflow'
                #return 0
                break
            else
                $tasks_sh "$action" "$args" "$desc" 
                if [ "$DEBUG" = false ];then
                    $tasks_sh motivation sport
                    $tasks_sh take_photo
                    sleep1 10
                fi
            fi
        fi
        sleep1 $waiting
        if [ "$REPORT" = true ];then
            increase_efficiency $count $max "$desc" "$file_report"
        fi
        let "count=count+1"
    done

    #exec $tasks_sh suspend "regardless workflow"
}
$@
