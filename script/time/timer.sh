#!/bin/bash 
# about file:
# choose a workflow , run serial.sh
#export VERBOSE=true
trace "$*"
file_locker=/tmp/timer
delay=30

workflow=''
workflow_d=''

export waiting=${1:-60}   # Defaults to /tmp dir.
export DEBUG=${2:-false}   # Defaults to /tmp dir.

#export DEBUG=true
if [ $DEBUG = true ];then
 waiting=5
fi

trace   "waiting  $waiting"

run(){
    while :;do

        
    notify-send "DEBUG: $DEBUG:"
    notify-send "VERBOSE: $VERBOSE"
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
#generate_cfg cake
#generate_from_cfg cake
#baking

    sleep1 5
    $SCRIPT_DIR/more/serial.sh read_lines "$waiting"
}
#unlocker
run
#popd > /dev/null
#exit 0



