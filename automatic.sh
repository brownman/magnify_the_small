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

increase_efficiency(){
    count="$1"
    max="$2"
    task="$3"
    local str2="$count of $max"
    $( gxmessage "$str2" -title "Efficiency Report" $GXMESSAGET  -buttons 'low:0,medium:1,high:2' "Task: $task"  )
    local level="$?"
    local file1=$TODAY_DIR/txt/efficiency.txt
    echo "level: $level"
    echo "$task:$level" >> $file1
    gedit $file1
        
}

read_lines(){
    echo2 'read_lines()'
    local file_guide="$1"
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
count=0
max=${#lines[@]}
echo "executing $max tasks" | flite
    for line in "${lines[@]}"
    do


        $tasks_sh motivation sport
        echo "$line "
  
            desc=$( echo $line | awk -F '|' '{print $2}' )
            command=$( echo $line | awk -F '|' '{print $1}' )

            notify-send "TASK:" "$desc"
            ( echo "$desc" | flite &)
            #( echo0 "$desc" &)
            #exec



            cmd1='$tasks_sh $command "$desc"'

            eacher "$tasks_sh $command"  "$desc" #eacher '$tasks_sh time_is_limited' 'it should take a while' 

increase_efficiency $count $max $command
        sleep1 $WORKFLOW_DELAY

    let "count=count+1"
    done

    sleep1 60
    #exec $tasks_sh suspend "regardless workflow"
}

if [ -e $locker ];then
    echo -n  "file exist: "
    red "$locker"
    echo -n "assume proccess is running"
    #echo "process already running" | flite
 pids1=`cat $locker`
 msg2="kill running process ?"
result1=$( messageYN "y/n question" "$msg2" )
    if [[ $result1 -eq 2 ]];then
    `rm $locker`
    `kill -9 $pids1`
    #$0
    echo "exec $0 ?"

  ./$0             #  Script recursively spawns a new instance of itself.
    
    #echo 'process terminated' | flite
    fi


    
else
    green 'create $locker'
    touch $locker
    echo $$ > $locker

    msg0="I follow my commitments And I never lie"
    #"do you know what to do next?"
    #are you doing what you wished for ?"
    echo "have you already planned what to do next? "
    echo "sport/job"

result1=$( messageYN "y/n question" "$msg0" )
    if [[ $result1 -eq 2 ]];then
        echo 'I am free'
        echo "$msg1"
        #sleep1 60
        read_lines $CFG_DIR/workflow.txt
  
    else
        red 'Suspending..'
        $timer_sh motivation
        xterm -e  $PLUGINS_DIR/suspend.sh
    fi




  #yellow "removing $locker"
#  `rm $locker`






fi
exit 0



