# about file:
# run circle of tasks: 
# input: workflow.txt
# execute: tasks.sh $workflow
#
. $TIMERTXT_CFG_FILE

increase_efficiency(){
    count="$1"
    max="$2"
    task="$3"
    local str2="$count of $max"
    $( gxmessage "$str2" -title "Efficiency Report" $GXMESSAGET  -buttons 'low:0,medium:1,high:2' "Task: $task"  )
    local level="$?"
    local file1=$4
    #CFG_DIR/txt/efficiency.txt
    echo "level: $level"
    echo "##$task:$level" >> $file1
    #gedit $file1
        
}

read_lines(){
    echo2 'read_lines()'
    local file_guide="$1"
    local waiting="$2"
#    old_IFS=$IFS
#    IFS=$'\n'
#    lines=($(cat $file_guide)) # array
#    IFS=$old_IFS
#

# Bash

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


echo "lines: ${lines}"

max=${#lines[@]}
count=1
max=${#lines[@]}
flite "executing $max tasks" 



    for line in "${lines[@]}"
    do
        #$tasks_sh motivation sport
        echo "$line "
            command=$( echo $line | awk -F '|' '{print $1}' )
            args=$( echo $line | awk -F '|' '{print $2}' )
            desc=$( echo $line | awk -F '|' '{print $3}' )
            notify-send "TASK: $desc" "$args"
            flite "$desc" true
            #( echo0 "$desc" &)
            #cmd1='$tasks_sh $command "$desc"'
            eacher "$tasks_sh $command $args"  "$desc" #eacher '$tasks_sh time_is_limited' 'it should take a while' 
increase_efficiency $count $max "$command" "$file_guide"
        sleep1 $waiting
    let "count=count+1"
    done

    
    #sleep1 $waiting
    #exec $tasks_sh suspend "regardless workflow"
}
$@
