# about file:
# choose a workflow , run serial.sh


pushd `dirname $0` > /dev/null
. loader.sh

#export VERBOSE=true
#export DEBUG=true
#file_locker=/tmp/lock1


workflow=''
workflow_d=''

export waiting=${1:-60}   # Defaults to /tmp dir.
if [ $DEBUG = true ];then
 waiting=5
fi

trace   "waiting  $waiting"

run(){
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
    
  #generate_cfg 
  unpack_subject from workflow
  unpack_subject to story
  unpack_subject to cake 
  exiting

#generate_cfg cake
#generate_from_cfg cake
#baking

    sleep1 5
    $SCRIPTS_DIR/serial.sh read_lines "$waiting"
}
unlocker timer 60
popd > /dev/null
exit 0



