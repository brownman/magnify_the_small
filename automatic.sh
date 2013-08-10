# about file:
# run circle of tasks: 
# input: workflow.txt
# execute: tasks.sh $workflow
#

export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/timer.cfg
. $TIMERTXT_CFG_FILE
#eval $PWD/public/cfg/tmp/mute.sh
#sleep 20
#exiting
export locker=/tmp/lock1
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
            #$tasks_sh update_statistics &
            #$tasks_sh publish_report &
            #sleep1 120
            break
        else
            desc=$( echo $line | awk -F '|' '{print $2}' )
            command=$( echo $line | awk -F '|' '{print $1}' )
            notify-send "TASK:" "$desc"
            echo "$desc" | flite
            #exec
            $tasks_sh $command "$desc"
        fi
        sleep1 60
    done

    sleep1 10
    #exec $tasks_sh suspend "regardless workflow"
}

if [ -e $locker ];then
    echo -n  "file exist: "
    red "$locker"
    echo -n "assume proccess is running"
    echo "process already running" | flite
    pids1=`cat $locker`

    `rm $locker`
    `kill -9 $pids1`

    
else
    green 'create $locker'
    touch $locker
    echo $$ >> $locker

    msg0="do you know what to do next?"
    #are you doing what you wished for ?"
    echo "have you already planned what to do next? "
    echo "sport/job"

result1=$( messageYN "y/n question" "$msg0" )
    if [ "$result1" = 1 ];then
        echo 'I am free'
        echo "$msg1"
        #sleep1 60
        read_lines $CFG_DIR/workflow.txt
  
    else
        red 'Suspending..'
        xterm -e  $PLUGINS_DIR/suspend.sh
    fi




  yellow "removing $locker"
    `rm $locker`

fi

exit 0



