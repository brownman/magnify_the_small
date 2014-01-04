
#notify_send1 "reminder: increase motivation" "$@"

delay=5
file_locker=/tmp/increase_motivation

one(){

    local delay=181

if [ "$delay" ];then
    



        #local  trigger=$( random_from_subject1 trigger)
        
        local  trigger=$( zenity1 $DATA_DIR/txt/trigger.txt )
        helper0 "$trigger" $file_log  
        local answer=$(gxmessage -entrytext ""  -title 'new reason:' "$trigger" $GXMESSAGET )
        update_points "$answer" collected
tasker update_points "$answer"
        helper0 "$answer" "$file_log"

        local  cmd="sleep2 '$answer' '$trigger' '$delay'" 
        res=$(commander "$cmd")


fi

}
loop(){

    #while :;do
echo
    #done

}

run(){
   one 
}

#unlocker
run
