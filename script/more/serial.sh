# about file:
# run circle of tasks: 
# input: workflow.txt
# execute: tasks.sh $workflow
#



trace "serial.sh got: 1:$1 2:$2"




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
    done < $file_workflow

    #gxmessage -file $file_workflow "$GXMESSAGET" -title 'ensure this workflow:'
messageFYN1 "$file_workflow" \
'ensure this workflow:'
local res=$?
if [ $res -eq $NO ];then
exiting
else
    notify-send1 'continue' 
    #'to first task'
fi


    local max=${#lines[@]}


    local max_efficiency=$( tasker config level $max )
#assert_equal_str "$max_efficiency"
    if [ $max_efficiency = '' ];then
return
    fi
    if [ $max_efficiency -eq 0 ];then

optional        "gedit $DATA_DIR/yaml/one.yaml"
        return
    fi


    #let "max_efficiency=max_efficiency+1"



    count=1
    local str_tasks=''

    gxmessage -file "$file_logger" $GXMESSAGET
    for line in "${lines[@]}"
    do
        notify-send1 'continue on moving your ass around'
        local str_percent="$count of $max_efficiency"
        local     action=$( echo "$line" | awk -F '|' '{print $1}' )
        local     desc=$( echo "$line" | awk -F '|' '{print $2}' )

        $( messageYN1 "$desc" ' next task?'  )
        local result=$?
        if [[ $result -eq $YES ]];then
            str_tasks="$str_tasks _ $count: $action"
            notify-send3 "$str_percent"
            notify-send3 "TASK: $desc"
            flite "$desc" true 
            local args=( ${action} )
            local res1=$(  "${args[@]}" )
            notify-send1 'next' 'task' 
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

    $( messageYN1 "report:" ' are you efficient ? (answer: left or right)'  )
    local result1=$?
    if [ $result1 -eq "$YES" ];then

        #update_file $file_logger
        local str="$str_tasks"
    tasker update_points "$str"

    fi




}
read_lines

