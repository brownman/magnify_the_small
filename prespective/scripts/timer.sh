# about file:
# choose a workflow to parse
# run 
#

pushd `dirname $0` > /dev/null
. loader.sh

#export VERBOSE=true
#export DEBUG=true
export locker=/tmp/lock1


workflow=''
workflow_d=''

export waiting=${1:-60}   # Defaults to /tmp dir.
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

generate(){
    local name=$1
local file=$CFG_DIR/${name}.cfg

  #local result=$( parse_subject $name )
    #echo "$result" > $file
    #trace 'generated file:'
#cat $file
parse_subject $name $file
}


run_workflow(){
    
  generate workflow
generate cake
baking

    sleep1 5
    $SCRIPTS_DIR/serial.sh read_lines "$waiting"
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

    fi
        #./$0
    #else
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


}
unlock

popd > /dev/null
exit 0



