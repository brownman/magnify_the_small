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
        notify-send3 "wow! cycles: $count1"
     
        if [ "$DEBUG" = false ];then
            #tasker motivation glossary 
            trace ''
        fi
        #update_commander
        #cmd=".$file_loader"
        #commander "$cmd"
cmd='tasker motivation koan'
every  "$cmd"
#force_koan 
tasker resources &

        run_workflow
        #sleep1 $waiting
#        if [ "$DEBUG" = false ];then
#            random_quote_before  
#        fi
    done
    #random_quote_after    
}
#force_koan(){
#   tasker add_koan &
#   flite 'add 1 koan'
#   sleep1 10
#        tasker cfg1 xdg-open 'http://www.tldp.org/LDP/abs/html/' &
#  tasker cfg1 xdg-open http://mywiki.wooledge.org/ & 
#
#
#}

run_workflow(){
    sleep1 2
    $SCRIPT_DIR/more/serial.sh read_lines 
    #"$waiting"
}
unlocker


