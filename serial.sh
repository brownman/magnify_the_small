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
    echo2 "read_lines() got:  1:$1 2:$2"
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
        $tasks_sh motivation sport
        echo "$line "
            command=$( echo $line | awk -F '|' '{print $1}' )
            args=$( echo $line | awk -F '|' '{print $2}' )
            desc=$( echo $line | awk -F '|' '{print $3}' )
            notify-send "TASK: $desc" "$args"
            flite "$desc" true
            #( echo0 "$desc" &)
            #cmd1='$tasks_sh $command "$desc"'
            eacher "$tasks_sh $command $args"  "$desc ?" "$waiting" "task: $count/$max" 
            result="$?"


            echo -n  "eacher result:"
            green "$result"
            if [[ $result -eq 0 ]];then
            echo 'returning'
            #return 0
            break
            fi


#sleep1 $waiting
increase_efficiency $count $max "$desc" "$CFG_DIR/blank.yaml"
    let "count=count+1"
    done

    #exec $tasks_sh suspend "regardless workflow"
}
$@
