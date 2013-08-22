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



if [ -e $locker ];then
    echo -n  "file exist: "
    red "$locker"
    echo -n "assume proccess is running"
    pids1=`cat $locker`
    msg2="kill running process ?"
    result1=$( messageYN  "$msg2" )
    if [[ $result1 -eq 2 ]];then
        `rm $locker`
        `kill -9 $pids1`
        #./$0             #  Script recursively spawns a new instance of itself.
    fi
    #./$0
else
    green 'create $locker'
    touch $locker
    echo $$ > $locker

    $tasks_sh show_file $CFG_DIR/blank.yaml
    #$tasks_sh reminder
    
    route=$($tasks_sh chooser workflows)
    if [ $route != '' ];then
        workflow_file=$WORKFLOWS_DIR/workflow_$route.cfg 
        $tasks_sh show_file $workflow_file
        $PWD/serial.sh read_lines $workflow_file "$waiting"
    fi

    $tasks_sh motivation sport
    #play $PWD/drip.ogg  -trim $TIME_STR
    flite 'end of task series'
fi
exit 0



