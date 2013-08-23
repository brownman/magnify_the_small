# about file:
# choose a workflow to parse
# run 
#



export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/user.cfg
. $TIMERTXT_CFG_FILE
export locker=/tmp/lock1
workflow=''
workflow_d=''
waiting=${1:-60}   # Defaults to /tmp dir.
green   "waiting  $waiting"
before(){
    local result1=0

    if [ -e $locker ];then
        echo -n  "file exist: "
        red "$locker"
        echo -n "assume proccess running: "
        pids1=`cat $locker`
        cyan "$pids1"
        msg2="kill running process ?"

        $( messageYN  "$msg2" )


        result1="$?"

        cyan "result: $result1"
        if [[ $result1 -eq 2 ]];then
            echo 'killing'
            `rm $locker`
            `kill -9 $pids1`
            #./$0             #  Script recursively spawns a new instance of itself.
        else
            echo 'skipping'
        fi
        #./$0
    else
        green 'create $locker'
        touch $locker
        echo $$ > $locker
        while :;do


            local route=$($tasks_sh chooser workflows)
            echo "route is: $route"
            #local route='motivation'
            if [ "$route" != '' ];then
                workflow_file=$WORKFLOWS_DIR/workflow_$route.cfg 
                echo "$workflow_file"
                
                #$tasks_sh show_file $workflow_file
                $PWD/serial.sh read_lines "$workflow_file" "$waiting"
            else
                $tasks_sh show_file $CFG_DIR/blank.yaml
            $tasks_sh motivation guidance 
            echo 'skip'
            fi



        done
    fi

}
before
exit 0



