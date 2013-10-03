~/.magnify_the_small/private/old/oldy1/old/learn/python_koans
1:/home/dao01/.magnify_the_small/prespective/public/cfg/workflow.cfg

execute_one(){

    #trace "line: $line " "line: "
    action=$( echo $line | awk -F '|' '{print $1}' )
    args0=$( echo $line | awk -F '|' '{print $2}' )
    #trace "args0: $args0"
    #trace "$tasks_sh fetch $args0"
    if [ "$arg0" != '' ];then
        args=$( $tasks_sh fetch "$args0" )
    else
        args=''
    fi
    #trace "args: $args"
    #exiting
    if [ "$args" = '' ];then
        flite 'empty line'
        sleep1 2
        flite 'breaking'
        break
    fi
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

}

