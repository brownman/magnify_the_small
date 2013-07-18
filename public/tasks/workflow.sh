#!/bin/bash

# about file:
# parse suspension series by editing: commenting/uncommenting the bank of tasks: workflow.txt 
#
#
. $TIMERTXT_CFG_FILE

file=$STORY_DIR/workflow.txt
workflow=''
workflow_d=''

green 'workflow.sh'
#line=$( cat $file | head -1 )
#desc=$( echo $line | awk -F '|' '{print $2}' )
#command=$( echo $line | awk -F '|' '{print $1}' )
#
#


read_lines(){
    echo2 'read_lines()'
    local file_guide=$file
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
        fi
    done

}
function myfunc()
{
    local  __resultvar=$1
    local  myresult='some value'
    if [[ "$__resultvar" ]]; then
        eval $__resultvar="'$myresult'"
    else
        echo "$myresult"
    fi
}




__workflow="$1"
__workflow_d="$2"

read_lines
#cyan "new workflow: $workflow"
#cyan "new workflow_d: $workflow_d"

if [[ "$__workflow_d" ]]; then
    eval $__workflow_d="'$workflow_d'"
fi 
if [[ "$__workflow" ]]; then
    eval $__workflow="'$workflow'"
fi 

red "$__workflow"