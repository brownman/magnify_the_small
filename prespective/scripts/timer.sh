# about file:
# choose a workflow to parse
# run 
#

pushd `dirname $0` > /dev/null
#reset
cd ../public
export TIMERTXT_CFG_FILE=$PWD/cfg/user.cfg
. $TIMERTXT_CFG_FILE
#export VERBOSE=true
#export DEBUG=false
export locker=/tmp/lock1


workflow=''
workflow_d=''

waiting=${1:-60}   # Defaults to /tmp dir.
if [ $DEBUG = true ];then
 waiting=5
fi

trace   "waiting  $waiting"

restart(){
    while :;do

        
    tracen "DEBUG: $DEBUG:"
    tracen "VERBOSE: $VERBOSE"
        #. $TIMERTXT_CFG_FILE
        if [ "$DEBUG" = false ];then
        $tasks_sh motivation glossary
        fi

        run_workflow
        sleep1 $waiting
        if [ "$DEBUG" = false ];then
            random_quote_before  
        fi
    done
    random_quote_after    


}


run_workflow(){
    
    local result=$( parse_subject workflow )
    echo "$result" > $file_workflow 
 #'workflow file is:'
    gxmessage -file $file_workflow $GXMESSAGET -title 'generated workflow:'

    sleep1 5
    $SCRIPTS_DIR/serial.sh read_lines "$file_workflow" "$waiting"
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

        #$( messageYN1  "$msg2" )


        #result1="$?"
        result1=1

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



