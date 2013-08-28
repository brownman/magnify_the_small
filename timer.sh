# about file:
# choose a workflow to parse
# run 
#



#export TIMERTXT_CFG_FILE=~/.magnify_the_small/public/cfg/user.cfg
#. $TIMERTXT_CFG_FILE
. $PWD/public/cfg/user.cfg
export locker=/tmp/lock1


workflow=''
workflow_d=''
waiting=${1:-60}   # Defaults to /tmp dir.
green   "waiting  $waiting"
menu0(){
    flite 'update time frame'
    local option=$($tasks_sh chooser sleeper )
    echo "$option"
    
}
menu1(){
  
    $tasks_sh commitment
}
menu2(){
    local route=$($tasks_sh chooser workflows)
    echo "$route"
}

steps(){
    #local route='life'

    local option=$( menu0 )
    echo "$option"
    eval "do_$option"
    sleep1 60
    menu1
    sleep1 60
    local route=$( menu2 )
    #$tasks_sh chooser workflows)
    echo "route is: $route"
    flite "push forward - $route"

    if [ "$route" != '' ];then
        run_workflow $route
    else
        $tasks_sh show_file $CFG_DIR/blank.yaml
        #$tasks_sh motivation guidance 
        #echo 'skip'
    fi


}

run_workflow(){
    local route="$1" 
    workflow_file=$WORKFLOWS_DIR/workflow_$route.cfg 
    echo "$workflow_file"

    #$tasks_sh show_file $workflow_file

    $PWD/serial.sh read_lines "$workflow_file" "$waiting"



}

unlock(){
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

           steps 
            #$PROJECT_DIR/test.sh

            #$PROJECT_DIR/serial.sh read_lines "$workflow_file" "$waiting"

        done
    fi

}
unlock

exit 0



