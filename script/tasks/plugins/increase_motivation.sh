
notify-send1 "reminder: increase motivation" "$@"

delay=5
file_locker=/tmp/increase_motivation

loop(){

    local delay=180

    delay=$(gxmessage -entrytext "$delay" -title 'enter new' 'delay' $GXMESSAGET)
    local answer=""
if [ "$delay" ];then
    

    while :;do
reload_cfg
        local  trigger=$( random_from_subject1 trigger)
        helper0 "$trigger" $file_log  
        local answer=$(gxmessage -entrytext ""  -title 'new reason:' "$trigger" $GXMESSAGET )

        #sub-funcs can run break command
        eval 'helper0 "$answer" "$file_log"'

        local  cmd="sleep2 '$answer' '$trigger' '$delay'" 
        res=$(commander "$cmd")
        #silently_run "$cmd"
    done

fi

}

run(){
    loop
}

#run
unlocker
