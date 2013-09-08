# about file:
# choose a workflow to parse
# run 
#

pushd `dirname $0` > /dev/null
#reset
cd ../public
export TIMERTXT_CFG_FILE=$PWD/cfg/user.cfg

. $TIMERTXT_CFG_FILE
#
#pushd `dirname $0` > /dev/null
#export TIMERTXT_CFG_FILE=../public/cfg/user.cfg
#. $TIMERTXT_CFG_FILE
export locker=/tmp/lock1


workflow=''
workflow_d=''
waiting=${1:-60}   # Defaults to /tmp dir.
trace   "waiting  $waiting"

restart(){
    trace "$DEBUG: DEBUG:"
    while :;do

        . $TIMERTXT_CFG_FILE
        if [ "$DEBUG" = false ];then
            random_quote_before  
        fi

        $tasks_sh motivation glossary
        run_workflow
        sleep1 $waiting
        if [ "$DEBUG" = false ];then
            random_quote_after    
        fi
    done



}


run_workflow(){
    workflow_file=$CFG_DIR/workflow.cfg 
    #    $tasks_sh generate_file workflow $CFG_DIR/workflow.cfg
    #    sleep1 5
    #tracex "serial run? $SCRIPTS_DIR/serial.sh"
    $SCRIPTS_DIR/serial.sh read_lines "$workflow_file" "$waiting"
}
unlock(){
    local result1=0

    if [ -e $locker ];then
        echo -n  "file exist: "
        red "$locker"
        echo -n "assume proccess running: "
        pids1=`cat $locker`
        trace "$pids1"
        msg2="kill running process ?"

        $( messageYN1  "$msg2" )


        result1="$?"

        trace "result: $result1"
        if [[ $result1 -eq 1 ]];then
            echo 'killing'
            `rm $locker`
            `kill -9 $pids1`
            #./$0             #  Script recursively spawns a new instance of itself.
        else
            echo 'skipping'
        fi
        #./$0
    else
        trace 'create $locker'
        touch $locker
        echo $$ > $locker

        #        while :;do
        #
        #           steps 
        #            #$PROJECT_DIR/test.sh
        #
        #            #$PROJECT_DIR/serial.sh read_lines "$workflow_file" "$waiting"
        #
        #        done
        restart
    fi

}
unlock

popd > /dev/null
exit 0



