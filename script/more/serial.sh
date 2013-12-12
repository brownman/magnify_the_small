# about file:
# run circle of tasks: 
# input: workflow.txt
# execute: tasks.sh $workflow
#



trace "serial.sh got: 1:$1 2:$2"

#increase_efficiency(){
#    count="$1"
#    max="$2"
#    task="$3"
#    local str2="$count of $max"
#    gxmessage "$str2" -title "Efficiency Report" $GXMESSAGET  -buttons 'low:0,medium:1,high:2' "Task: $task"  
#    local level="$?"
#    local file1=$4
#    #CFG_DIR/txt/efficiency.txt
#    echo "level: $level"
#    echo "##$task:$level" >> $file1
#    #gedit $file1
#}
execute_line(){
    local line="$1"

    #local msg="$2"


    local     action=$( echo "$line" | awk -F '|' '{print $1}' )
    local     desc=$( echo "$line" | awk -F '|' '{print $2}' )
    #local    desc=$( echo "$line" | awk -F '|' '{print $3}' )
    #local    args=''
    #if [ "$args0" != '' ];then
    #    #args=$( fetching "$args0" )
    #    parse_subject  "$args0" 
    #fi
    #
    #assert_equal_str "$action"
    notify-send3 "TASK: $desc"
    #flite "$desc" 
    #update_commander 
    local args=( ${action} )
    #eval show_args
    #"${args}"

    local res1=$(  "${args[@]}" )
    #echo "$res1"
    trace "$res1"
    #commander "$cmd"

    #limit "${arr_actionp[]}"
    #"$args0"
    #"$desc" 

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
    done < $DATA_DIR/tmp/workflow.tmp 



    local max=${#lines[@]}


    local max_efficiency=$( tasker cfg1 level $max )



    let "max_efficiency=max_efficiency+1"

    update_file $file_logger "$time1:\t$max_efficiency"

    count=1

    for line in "${lines[@]}"
    do
        notify-send1 'continue on moving your ass around'
        local str2="$count of $max_efficiency"


        $( messageYN1 "$str2" ' next task?'  )
        local result=$?
        if [[ $result -eq 1 ]];then


            notify-send1 "$str2"

            execute_line "$line" 
            sleep1 8
            let "count=count+1"
        else
            flite 'breaking'
            break
        fi
        if [ $count -gt  $max_efficiency  ];then
            flite 'efficiency level is smaller than counter'
            break
        fi


    done

}
read_lines

