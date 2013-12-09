#!/bin/bash 
# about file:
# choose a workflow , run serial.sh
file_locker=/tmp/timer
delay=30

#workflow=''
#workflow_d=''

export DEBUG=${2:-false}
#waiting="$CYCLE"
notify-send1 'timer.sh waiting is ' "$waiting"


run(){
    local count1=0
    while :;do
        let "count1=count1+1"
        notify-send3 "wow! rounds: $count1"
     
        if [ "$DEBUG" = false ];then
            #tasker motivation glossary 
            trace ''
        fi
        run_workflow
        #sleep1 $waiting
#        if [ "$DEBUG" = false ];then
#            random_quote_before  
#        fi
    done
    #random_quote_after    
}


run_workflow(){
    sleep1 5
    $SCRIPT_DIR/more/serial.sh read_lines 
    #"$waiting"
}
unlocker


