# about file:
# run circle of tasks: 
# input: workflow.txt
# execute: tasks.sh $workflow
#

file_guide="$CFG_DIR/workflow.cfg"
waiting="$1"
trace "serial.sh got: 1:$1 2:$2"

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
execute_line(){
    local line="$1"
    local msg="$2"
    #trace "$line" "1 line"
    #evaluate_
    #notify-send "" "$msg"
    parse_line "$line" "$msg"
}

parse_line(){
    local line="$1"

    local msg="$2"


    local     action=$( echo "$line" | awk -F '|' '{print $1}' )
    local     args0=$( echo "$line" | awk -F '|' '{print $2}' )
    local    desc=$( echo "$line" | awk -F '|' '{print $3}' )
    local    args=''
if [ "$args0" != '' ];then
    args=$( fetching "$args0" )
fi

    notify-send "TASK: $msg" "$desc"
    flite "$desc" true


    $tasks_sh $action "$args" "$desc" 

}


read_lines(){
    trace "read_lines() got:  1:$1 2:$2"


    local args=''

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

            local str2="$count of $max"
        if [[ $count -eq 1 ]];then

            execute_line "$line" "$str2"
        else

            $( messageYN1 'continue to next task?' 'workflow efficiency:' )
            local result=$?
            #tracex 'is 1?' "$result"
            if [[ $result -eq 1 ]];then

                execute_line "$line" "$str2"
                sleep1 $waiting
$tasks_sh motivation sport
                let "count=count+1"
            else
                flite 'breaking'
                break
            fi

        fi
    done
    #flite 'end of workflow'

    #exec $tasks_sh suspend "regardless workflow"
}
eval $1 '"$2" "$3" "$4"'

