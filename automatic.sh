# about file:
# run circle of tasks: 
# input: workflow.txt
# execute: tasks.sh $workflow
#

export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE

workflow=''
workflow_d=''
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
        else
            desc=$( echo $line | awk -F '|' '{print $2}' )
            command=$( echo $line | awk -F '|' '{print $1}' )
             exec $tasks_sh $command "$desc"
        fi
        sleep1 40
    done

    sleep1 60
    exec $tasks_sh suspend "regardless workflow"
}
read_lines $CFG_DIR/workflow.txt
#series1  "$workflow" "$workflow_d"  
#read_lines $CFG_DIR/url.txt
#series1  "$workflow" "$workflow_d"  true

