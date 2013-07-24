# about file:
# run task in circle
#
. $TIMERTXT_CFG_FILE
#update_lang it

source $tasks_sh
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
            #red 'empty line'  
        else
            desc=$( echo $line | awk -F '|' '{print $2}' )
            command=$( echo $line | awk -F '|' '{print $1}' )
            #workflow="$workflow,$command"
            #workflow_d="$workflow_d,$desc"
            #red "workflow_d: $workflow_d"
            #$tasks_sh "$command"

             exec $tasks_sh act "$command" "$desc"


        fi

        sleep1 40
    done

    sleep1 60
    $tasks_sh suspend
}
read_lines $CFG_DIR/workflow.txt
#series1  "$workflow" "$workflow_d"  
#read_lines $CFG_DIR/url.txt
#series1  "$workflow" "$workflow_d"  true


