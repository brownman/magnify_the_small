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
#waiting=$("$1" || 60 )
waiting=${1:-60}   # Defaults to /tmp dir.
green   "waiting  $waiting"

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
    #gedit $file1
        
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
count=1
max=${#lines[@]}
flite "executing $max tasks" 
$tasks_sh show sport
    for line in "${lines[@]}"
    do
        $tasks_sh motivation sport
        echo "$line "
            command=$( echo $line | awk -F '|' '{print $1}' )
            args=$( echo $line | awk -F '|' '{print $2}' )
            desc=$( echo $line | awk -F '|' '{print $3}' )
            notify-send "TASK: $desc" "$args"
            flite "$desc" true
            #( echo0 "$desc" &)
            #cmd1='$tasks_sh $command "$desc"'
            eacher "$tasks_sh $command $args"  "$desc" #eacher '$tasks_sh time_is_limited' 'it should take a while' 
increase_efficiency $count $max "$command"
        sleep1 $waiting
    let "count=count+1"
    done
    #sleep1 $waiting
    #exec $tasks_sh suspend "regardless workflow"
}

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
else
    green 'create $locker'
    touch $locker
    echo $$ > $locker

    msg0="I have the power to change"
    #follow my commitments And I never lie"
    #"do you know what to do next?"
    #are you doing what you wished for ?"
    echo "have you already planned what to do next? "
    echo "sport/job"


        read_lines $CFG_DIR/workflow.txt
  
fi
exit 0



