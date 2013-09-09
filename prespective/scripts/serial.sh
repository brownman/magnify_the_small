# about file:
# run circle of tasks: 
# input: workflow.txt
# execute: tasks.sh $workflow
#


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
    trace "$line" "1 line"
    #evaluate_
    parse_line "$line"
}

parse_line(){
local line="$1"
local     action=$( echo "$line" | awk -F '|' '{print $1}' )
local     args0=$( echo "$line" | awk -F '|' '{print $2}' )
 local    desc=$( echo "$line" | awk -F '|' '{print $3}' )
local    args=''

        args=$( fetching "$args0" )
    trace "args: $args"
 notify-send "TASK: $desc" "$args"
        #flite "$desc" true

$tasks_sh $action "$args" 
#"$desc" 

}


read_lines(){
    trace "read_lines() got:  1:$1 2:$2"
file_guide="$1"
waiting="$2"
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
        execute_line "$line"
        sleep1 $waiting
        let "count=count+1"
    done

    #exec $tasks_sh suspend "regardless workflow"
}
eval $1 '"$2" "$3" "$4"'

